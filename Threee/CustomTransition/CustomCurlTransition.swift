//
//  CustomCurlTransition.swift
//  Threee
//
//  Created by Paulo José on 24/08/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

enum CurlType {
    case up
    case down
}

class CustomCurlTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let type: CurlType
    
    init(type: CurlType) {
        self.type = type
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        let fromView = transitionContext.containerView
        
        UIView.transition(from: fromView,
                          to: toView,
                          duration: 1,
                          options: self.type == .up ? UIView.AnimationOptions.transitionCurlUp : UIView.AnimationOptions.transitionCurlDown) { (complete) in
            transitionContext.completeTransition(complete)
        }
        
    }
    
    
    
    
}
