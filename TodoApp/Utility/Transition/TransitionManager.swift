//
//  TransitionManager.swift
//  TodoApp
//
//  Created by Ugur Kilic on 10/04/2020.
//  Copyright © 2020 urklc. All rights reserved.
//

import UIKit

final class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning {

    private var isPresenting = false

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            let detailView = transitionContext.view(forKey: .to)!
            detailView.alpha = 0.0
            transitionContext.containerView.addSubview(detailView)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                detailView.alpha = 1.0
            }, completion: { isFinished in
                transitionContext.completeTransition(isFinished)
            })
        } else {
            transitionContext.containerView.addSubview(transitionContext.view(forKey: .from)!)
            transitionContext.completeTransition(true)
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension TransitionManager: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}
