//
//  Artist.swift
//  SwiftDemo04
//
//  Created by 黄永乐 on 17/3/2.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

struct Artist {
    let name: String?
    let bio: String
    let image: UIImage
    var works: [Work]
    
    init(name: String, bio: String, image: UIImage, works: [Work]) {
        self.name = name
        self.bio = bio
        self.image = image
        self.works = works
    }
    
    static func artistsFromBundle() -> [Artist] {
        var artistArr = [Artist]()
        guard let url = Bundle.main.url(forResource: "artists", withExtension: "json") else {
            return artistArr
        }
        do {
            //标记throws的API error需要try catch来捕获可能的异常，否则无法编译通过
            //https://onevcat.com/2016/03/swift-throws/
            let data = try Data(contentsOf: url)
            guard let rootObJ = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else {
                return artistArr
            }
            //AnyObject 表示任何class类型 Any表示任意类型，AnyObject是Any的子集
            guard let artistObjs = rootObJ["artists"] as? [[String : AnyObject]] else {
                return artistArr
            }
            
            for artistObj in artistObjs {
                if let name = artistObj["name"] as? String,
                    let bio = artistObj["bio"] as? String,
                    let imageName = artistObj["image"] as? String,
                    let image = UIImage (named: imageName),
                    let worksObj = artistObj["works"] as? [[String:String]]
                    {
                        var wokrs = [Work]()
                        for workObj in worksObj
                        {
                            if let workTitle = workObj["title"],
                                let workImageName = workObj["image"],
                                let workImage = UIImage (named: workImageName + ".jpg"),
                                let info = workObj["info"]
                                {
                                    wokrs.append(Work(title: workTitle,image: workImage,info:info,isExpanded:false))
                                }
                        }
                        let artist = Artist(name: name, bio: bio, image: image, works: wokrs)
                        artistArr.append(artist)
                    }
            }
        } catch {
            return artistArr
        }
        return artistArr
    }
}
