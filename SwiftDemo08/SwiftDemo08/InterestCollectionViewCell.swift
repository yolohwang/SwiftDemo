//
//  InterestCollectionViewCell.swift
//  SwiftDemo08
//
//  Created by YoloHwang on 17/3/15.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    var insterest: Interest! {
        didSet{
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        self.cellLabel.text = insterest.title
        self.cellImageView.image = insterest.featureImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
    
}
