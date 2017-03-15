//
//  Candy.swift
//  SwiftDemo5
//
//  Created by YoloHwang on 17/3/6.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class Candy: NSObject {
    var category: String
    var name: String
    
    init(category: String,name: String) {
        self.category = category
        self.name = name
    }

}
