//
//  MapDismissAnimatorController.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/23.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit
class MapDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    private let destinationFrame: CGRect
    init(destinationFrame: CGRect) {
        self.destinationFrame = destinationFrame
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
            else {
                return
        }
        snapshot.layer.cornerRadius = 8
        snapshot.layer.masksToBounds = true
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        fromVC.view.isHidden = true
        let duration = transitionDuration(using: transitionContext)
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/2) {
                    snapshot.frame = self.destinationFrame
                }
                UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 1/2) {
                    snapshot.alpha = 0
                }
        },
            completion: { _ in
                fromVC.view.isHidden = false
                snapshot.removeFromSuperview()
                if transitionContext.transitionWasCancelled {
                    toVC.view.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
