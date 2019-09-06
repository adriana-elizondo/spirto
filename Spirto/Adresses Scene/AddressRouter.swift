//
//  AddressRouter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/19.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

protocol AddressRoutingProtocol {
    func openMap()
}
class AddressRouter: NSObject, AddressRoutingProtocol {
    weak var viewController: AddressViewController?
    func openMap() {
        let mapController = MapViewController(nibName: nil)
        //mapController.transitioningDelegate = self
        viewController?.present(mapController, animated: true, completion: nil)
    }
}

extension AddressRouter: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AddressRouterPresentationController(with: viewController?.createAddressButton.frame ?? .zero)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard dismissed as? MapViewController != nil else {
            return nil
        }
        return MapDismissAnimationController(destinationFrame: viewController?.createAddressButton.frame ?? .zero)
    }
}
