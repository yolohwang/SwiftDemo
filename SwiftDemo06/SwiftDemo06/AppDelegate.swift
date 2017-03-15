//
//  AppDelegate.swift
//  SwiftDemo06
//
//  Created by YoloHwang on 17/3/8.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //test
        swiftBlock(feedURL: "YoloHwang") { (String) in
            print(String)
        }
        
        return true
    }

    //swift block
    fileprivate var completionHandler:((_ title: String) -> Void)?
    func swiftBlock(feedURL: String, completion:@escaping ((_ title: String) -> Void)) {
        completionHandler = completion
        completionHandler!(feedURL)
    }
}

