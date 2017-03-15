//
//  Utils.swift
//  SwiftDemo03
//
//  Created by 黄永乐 on 17/2/20.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

func dateFromSting(_ date: String) -> Date? {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "yyyy-MM-dd"
    return dateFormater.date(from: date)
}

func stringFromDate(_ date: Date) -> String {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "yyyy-MM-dd"
    return dateFormater.string(from: date)
}

