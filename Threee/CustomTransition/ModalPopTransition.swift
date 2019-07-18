//
//  ModalPopTransition.swift
//  Threee
//
//  Created by Paulo José on 18/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class ModalPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? AlertModalViewController,
            let fromView = fromViewController.view
            else { return }
        
        let containerView = transitionContext.containerView
        
        fromViewController.backdropView.alpha = 1
        
        guard let cardViewCenterY = fromViewController.cardViewCenterYAnchor else { return }
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
            fromViewController.backdropView.alpha = 0
            cardViewCenterY.constant = 600
            fromView.layoutIfNeeded()
        }, completion: { (true) in
            transitionContext.completeTransition(true)
        })
        
    }
}
