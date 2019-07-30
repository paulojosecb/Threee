//
//  CustomTransition.swift
//  Threee
//
//  Created by Paulo José on 18/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class ModalPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) as? AlertModalViewController,
            let toView = toViewController.view
        else { return }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
        
        
        toViewController.backdropView.alpha = 0
        
        guard let cardViewCenterY = toViewController.cardViewCenterYAnchor else { return }
        cardViewCenterY.constant = 500
        toView.layoutIfNeeded()

        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            
            toViewController.backdropView.alpha = 1
            cardViewCenterY.constant = 0
            toView.layoutIfNeeded()
        }, completion: nil)
        
        transitionContext.completeTransition(true)
    }
    

}
