//
//  PhotoCommentViewController.swift
//  SwiftDemo07
//
//  Created by YoloHwang on 17/3/10.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoScrollView: UIScrollView!
    @IBOutlet weak var photoTextField: UITextField!
    
    
    public var photoName: String!
    public var photoIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let photoName = photoName {
            photoImageView.image = UIImage (named: photoName)
        }
        
        let generalTapGesture = UITapGestureRecognizer (target: self, action:Selector.generaTap)
        view.addGestureRecognizer(generalTapGesture)
        let zoomTapGesture = UITapGestureRecognizer (target: self, action: Selector.zoomTap)
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(zoomTapGesture)
        
        //注册键盘相关事件的通知
        NotificationCenter.default.addObserver(self, selector: Selector.keyboardWillShowHandler, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: Selector.keyboardWillHideHandler, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func adjustInsetForKeyboard(isShow: Bool, notification: Notification) {
        guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame = value.cgRectValue
        let adjustmentHeight = (keyboardFrame.height) * (isShow ? 1 : -1)
        //photoScrollView.contentOffset 表示scrollview当前显示区域的顶点相对于其的frame的坐标
        //photoScrollView.contentSize 表示scrolleview可以滚动的区域，横竖
        //photoScrollView.contentInset 表示scrolleview四周的可以滚动区域//经常用于底部被遮挡的问题
        photoScrollView.contentInset.bottom += adjustmentHeight
        photoScrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    func keyboardWillShow(notification: Notification) {
        adjustInsetForKeyboard(isShow: true, notification: notification)
    }
    func keyboardWillHide(notification: Notification) {
        adjustInsetForKeyboard(isShow: false, notification: notification)
    }
    func openZoomingController(sender: AnyObject) {
        /*
        //segue不连线
        let destinationVC = ZoomedPhotoViewController()
        let segue: UIStoryboardSegue = UIStoryboardSegue (identifier: "zooming", source: self, destination: destinationVC) { 
            //self.present(destinationVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
        segue.perform()
        */
        //segue连线
        performSegue(withIdentifier: "zooming", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let id = segue.identifier
        if let zoomedPhotoViewController = segue.destination as? ZoomedPhotoViewController{
            if id == "zooming" {
                zoomedPhotoViewController.photoName = photoName
            }
        }
    }

}


extension Selector {
    static let keyboardWillShowHandler = #selector(PhotoCommentViewController.keyboardWillShow(notification:))
    static let keyboardWillHideHandler = #selector(PhotoCommentViewController.keyboardWillHide(notification:))
    static let generaTap = #selector(PhotoCommentViewController.dismissKeyboard)
    static let zoomTap = #selector(PhotoCommentViewController.openZoomingController(sender:))
}




