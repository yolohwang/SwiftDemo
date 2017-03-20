//
//  ImageViewController.swift
//  SwiftDemo08
//
//  Created by YoloHwang on 17/3/16.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    public var bigImage:UIImage!
    
    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet var tapGesture: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let bigImage = bigImage {
            bigImageView.image = bigImage
        }
        
    }
    
    @IBAction func tapGesture(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
