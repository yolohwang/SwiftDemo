//
//  ManagerPageViewController.swift
//  SwiftDemo07
//
//  Created by YoloHwang on 17/3/10.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class ManagerPageViewController: UIPageViewController {

    //transitionStyle 默认是pageCurl(卷曲样式类似翻书效果)不显示currentIndicator，Scroll(UIScrollView滚动效果)，显示currentIndicator
    var photos:[String] = ["photo1","photo2","photo3","photo4","photo5"]
    var currentIndicator: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        dataSource = self
        if let viewController = viewPhotoCommentController(index: currentIndicator ?? 0) {
            let viewControllers = [viewController]
            //.forward 从左到右
            setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
        }
        
    }
    

    fileprivate func viewPhotoCommentController(index:Int) -> PhotoCommentViewController? {
        //vc之间没有segue时instantiateViewController初始化一个，然后压栈，跳转
        //vc之间有segue时performSegue，直接跳转
        if let storyboard = storyboard,
            let pageVC = storyboard.instantiateViewController(withIdentifier: "PhotoCommentViewController") as? PhotoCommentViewController
        {
            pageVC.photoName = photos[index]
            pageVC.photoIndex = index
            return pageVC
        }
        return nil
    }

}

extension ManagerPageViewController: UIPageViewControllerDataSource {
    // In terms of navigation direction. For example, for 'UIPageViewControllerNavigationOrientationHorizontal', view controllers coming 'before' would be to the left of the argument view controller, those coming 'after' would be to the right.
    // Return 'nil' to indicate that no more progress can be made in the given direction.
    // For gesture-initiated transitions, the page view controller obtains view controllers via these methods, so use of setViewControllers:direction:animated:completion: is not required.
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PhotoCommentViewController {
            guard let index = viewController.photoIndex, index != 0 else {
                return nil
            }
            return viewPhotoCommentController(index: index - 1)
        }
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PhotoCommentViewController {
            guard let index = viewController.photoIndex, index != photos.count - 1 else {
                return nil
            }
            return viewPhotoCommentController(index: index + 1)
        }
        return nil
    }
    
    
    // A page indicator will be visible if both methods are implemented, transition style is 'UIPageViewControllerTransitionStyleScroll', and navigation orientation is 'UIPageViewControllerNavigationOrientationHorizontal'.
    // Both methods are called in response to a 'setViewControllers:...' call, but the presentation index is updated automatically in the case of gesture-driven navigation.
    // The number of items reflected in the page indicator.
    func presentationCount(for pageViewController: UIPageViewController) -> Int  {
        return photos.count
    }
    
    // The selected item reflected in the page indicator.
    func presentationIndex(for pageViewController: UIPageViewController) -> Int  {
        return currentIndicator ?? 0
    }
    

    
}
