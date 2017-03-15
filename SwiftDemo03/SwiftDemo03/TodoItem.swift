//
//  TodoItem.swift
//  SwiftDemo03
//
//  Created by 黄永乐 on 17/2/20.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class TodoItem: NSObject {

    var id: String
    var image: String
    var title: String
    var date: Date
    
    init(id: String,image: String,title: String, date: Date) {
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}
