//
//  AppDelegate.swift
//  SwiftDemo5
//
//  Created by 黄永乐 on 17/3/6.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        let splitViewController = window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        
        
        UISearchBar.appearance().barTintColor = UIColor.candyColor()
        UISearchBar.appearance().tintColor = UIColor.white
        UITextField.appearance().tintColor = UIColor.candyColor()
        
        return true
    }

    // MARK: - Split view
//    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
//        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
//        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
//        if topAsDetailController.detailItem == nil {
//            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
//            return true
//        }
//        return false
//    }

    
}

extension UIColor {
   static func candyColor() -> UIColor {
        return UIColor (red: 67/255, green: 205/255, blue: 135/255, alpha: 1.0)
    }
}


//在方法的func关键字前加上关键字static或class 都可以用于指定类方法。不同的是class关键字指定的类方法可以被子类重写，static 不可以
class calss1 {
    class func candColor1() {
        print("1111");
    }
    static func candyColor2() {
        print("2222");
    }
    func candyColor3() {
        print("3333");
    }
}

class calss2: calss1 {
    override class func candColor1() {
        
    }
}
