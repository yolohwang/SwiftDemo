//
//  ArtistDetailTableViewCell.swift
//  SwiftDemo04
//
//  Created by 黄永乐 on 17/3/4.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class ArtistDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var moreInfoTextView: UITextView!

    @IBOutlet weak var workImageView: UIImageView!

    @IBOutlet weak var workTitleLable: UILabel!
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func setUpUI() {
        self.workTitleLable.backgroundColor = UIColor (white: 204/255, alpha: 1)
        self.workTitleLable.textAlignment = .center
        self.moreInfoTextView.textColor = UIColor (white: 144/255, alpha: 1)
        self.selectionStyle = .none
        self.workTitleLable.font = UIFont.preferredFont(forTextStyle: .headline)
        self.moreInfoTextView.font = UIFont.preferredFont(forTextStyle: .footnote)
    }
}
