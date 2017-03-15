//
//  Stopwatch.swift
//  SwiftDemo02
//
//  Created by 黄永乐 on 17/2/9.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class Stopwatch: NSObject {
    var counter: Double
    var timer: Timer
    
    override init() {
        self.counter = 0.0
        self.timer = Timer()
    }

}
