//
//  MenuViewController.swift
//  SwiftDemo10
//
//  Created by YoloHwang on 17/3/25.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    let transitionManager = TransitionManager()
    

    @IBOutlet weak var textImageView: UIImageView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var quoteImageView: UIImageView!
    @IBOutlet weak var linkImageView: UIImageView!
    @IBOutlet weak var chatImageView: UIImageView!
    @IBOutlet weak var audioImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self.transitionManager
    }

}
