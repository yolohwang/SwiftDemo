//
//  TransitionManager.swift
//  SwiftDemo10
//
//  Created by YoloHwang on 17/3/27.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class TransitionManager: NSObject {
    fileprivate var presenting = false
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let screens: (from: UIViewController, to: UIViewController) = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!,transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)
        
        let menuVC = !self.presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let bottomVC = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuVC.view
        let bottomView = bottomVC.view
        
        if (self.presenting) {
            offStageMenuContreller(menuVC)
        }
        container.addSubview(menuView!)
        container.addSubview(bottomView!)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        
        UIView.animate(withDuration: duration, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            if (self.presenting) {
                self.onStageMenuController(menuVC)
            } else {
                self.offStageMenuContreller(menuVC)
            }
            
        }) { (finished) in
            transitionContext.completeTransition(true)
            UIApplication.shared.keyWindow?.addSubview(screens.to.view)
        }
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func onStageMenuController(_ menuVC: MenuViewController) -> () {
        menuVC.view.alpha = 1.0
        
        menuVC.textImageView.transform = CGAffineTransform.identity
        menuVC.quoteImageView.transform = CGAffineTransform.identity
        menuVC.chatImageView.transform = CGAffineTransform.identity
        menuVC.audioImageView.transform = CGAffineTransform.identity
        menuVC.linkImageView.transform = CGAffineTransform.identity
        menuVC.photoImageView.transform = CGAffineTransform.identity
    }
    
    func offStage(_ offSet: CGFloat)-> CGAffineTransform {
        return CGAffineTransform (translationX: offSet, y: 0)
    }
    
    func offStageMenuContreller(_ menuVC: MenuViewController) {
        menuVC.view.alpha = 0
        let topRowOffset: CGFloat = 300
        let middleRowOffset: CGFloat = 150
        let bottomRowOffset: CGFloat = 50
        
        menuVC.textImageView.transform = offStage(-topRowOffset)
        menuVC.quoteImageView.transform = offStage(-middleRowOffset)
        menuVC.chatImageView.transform = offStage(-bottomRowOffset)
        
        menuVC.photoImageView.transform = offStage(topRowOffset)
        menuVC.linkImageView.transform = offStage(middleRowOffset)
        menuVC.audioImageView.transform = offStage(bottomRowOffset)
    }

}

extension TransitionManager: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}





















