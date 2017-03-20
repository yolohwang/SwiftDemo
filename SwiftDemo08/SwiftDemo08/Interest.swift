//
//  Interest.swift
//  SwiftDemo08
//
//  Created by YoloHwang on 17/3/15.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class Interest: NSObject {
    var id = ""
    var title = ""
    var descrip = ""
    var numberOfMembers = 0
    var numberOfPosts = 0
    var featureImage: UIImage!
    
    init(id: String, title:String, descrip: String, featureImage: UIImage) {
        self.id = id
        self.title = title
        self.descrip = descrip
        self.featureImage = featureImage
        numberOfPosts = 1
        numberOfMembers = 1
    }
    static func createInterests() ->[Interest] {
        return [
            Interest(id: "r1", title: "We Love Traveling Around the World", descrip: "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featureImage: UIImage(named: "r1")!),
            Interest(id: "r2", title: "Romance Stories", descrip: "We love romantic stories. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featureImage: UIImage(named: "r2")!),
            Interest(id: "r3", title: "iOS Dev", descrip: "Create beautiful apps. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featureImage: UIImage(named: "r3")!),
            Interest(id: "r4", title: "Race", descrip: "Cars and aircrafts and boats and sky. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featureImage: UIImage(named: "r4")!),
            Interest(id: "r5", title: "Personal Development", descrip: "Meet life with full presence. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featureImage: UIImage(named: "r5")!),
            Interest(id: "r6", title: "Reading News", descrip: "Get up to date with breaking-news. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featureImage: UIImage(named: "r6")!),
        ]
    }
    

}
