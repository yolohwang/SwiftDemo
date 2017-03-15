//
//  DetailViewController.swift
//  SwiftDemo5
//
//  Created by YoloHwang on 17/3/6.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var candyImageView: UIImageView!
    
    var detailCandy: Candy?{
        didSet{
            configureView()
        }
    }
    
    private func configureView() {
        if let detailCandy = detailCandy {
            if let titleLabel = titleLabel,
               let candyImageView = candyImageView {
             
                titleLabel.text = detailCandy.name
                candyImageView.image = UIImage (named: detailCandy.name)
                title = detailCandy.category
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let att = [NSForegroundColorAttributeName:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = att
//        navigationController?.navigationBar.backgroundColor = UIColor.candyColor()
        navigationController?.navigationBar.barTintColor = UIColor.candyColor()
        
        configureView()
    }


}
