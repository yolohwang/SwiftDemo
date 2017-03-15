//
//  Work.swift
//  SwiftDemo04
//
//  Created by 黄永乐 on 17/3/2.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

struct Work {
    let title: String
    let image: UIImage
    let info: String
    var isExpanded: Bool
    
    init(title: String,image: UIImage,info: String, isExpanded: Bool) {
        self.title = title
        self.image = image
        self.info = info
        self.isExpanded = isExpanded
    }
}
