//
//  NewsTableViewCell.swift
//  SwiftDemo06
//
//  Created by YoloHwang on 17/3/8.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

enum CellState {
    case expanded
    case collapsed
}

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel! {
        didSet {
            contentLabel.numberOfLines = contentLabel.numberOfLines == 4 ? 0 : 4
        }
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        setupUI()
//    }
//
//   
//    private func setupUI() {
//        
//    }
}
