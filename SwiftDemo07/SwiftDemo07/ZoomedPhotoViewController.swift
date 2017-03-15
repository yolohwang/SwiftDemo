//
//  ZoomedPhotoViewController.swift
//  SwiftDemo07
//
//  Created by YoloHwang on 17/3/12.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class ZoomedPhotoViewController: UIViewController {
    @IBOutlet weak var hehe: UIImageView!
    @IBOutlet weak var heheScrollView: UIScrollView!

    @IBOutlet weak var heheTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var heheBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var heheLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var heheTrailingContraint: NSLayoutConstraint!
    public var photoName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let photoName = photoName {
            hehe.image = UIImage (named: photoName)
        }
        heheScrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateMinZoomScale(forSize: view.bounds.size)
    }
    
    
    fileprivate func undateContraints(forSize size: CGSize) {
        //缩放过程计算缩放量设置frame
        let yOffset = max(0, (size.height - hehe.frame.height)/2)
        heheTopConstraint.constant = yOffset
        heheBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - hehe.frame.width)/2)
        heheLeadingConstraint.constant = xOffset
        heheTopConstraint.constant = xOffset
        //max 0 表示最大的放大量 就是原图的大小
        //立即实现布局
        view.layoutIfNeeded()
    }
    
    fileprivate func updateMinZoomScale(forSize size: CGSize) {
        // hehe.bounds 是图片的大小，此图比view大
        // min(widthScale, heightScale) 缩小x或y 铺满屏幕(也是最小)
        let widthScale = size.width / hehe.bounds.width
        let heightScale = size.height / hehe.bounds.height
        let minScale = min(widthScale, heightScale)
        
        heheScrollView.minimumZoomScale = minScale
        heheScrollView.zoomScale = minScale
    }
}

extension ZoomedPhotoViewController: UIScrollViewDelegate {
    //设置可以缩放的子view
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return hehe
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        //缩放过程中hehe.frame 不断变化，hehe.bounds是不变的
        undateContraints(forSize: view.bounds.size)
    }
    
}







