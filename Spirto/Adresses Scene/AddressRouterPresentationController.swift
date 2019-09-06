//
//  AddressRouterPresentationController.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/22.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

class AddressRouterPresentationController: NSObject, UIViewControllerAnimatedTransitioning {
    var originframe: CGRect
    init(with originFrame: CGRect) {
        originframe = originFrame
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
            let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
            else {
                return
        }
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        snapshot.frame = originframe
        snapshot.alpha = 0
        snapshot.layer.cornerRadius = 8
        snapshot.layer.masksToBounds = true
        containerView.addSubview(snapshot)
        containerView.addSubview(toVC.view)
        toVC.view.isHidden = true
        let duration = transitionDuration(using: transitionContext)
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/2) {
                    snapshot.alpha = 1
                }
                UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 1/2) {
                    snapshot.layer.cornerRadius = 0
                    snapshot.frame = finalFrame
                }
            },
            completion: { _ in
                toVC.view.isHidden = false
                snapshot.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
