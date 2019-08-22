//
//  HomeViewControllerRouter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/24.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

protocol HomeRoutingLogic {
    func presentMenuItemDetail(with item: MenuItem.Item)
    func pushCheckoutController()
}

class HomeRouter: NSObject, HomeRoutingLogic {
    weak var viewController: UIViewController?
    weak var navigationController: UINavigationController?
    func presentMenuItemDetail(with item: MenuItem.Item) {
        let detailController = MenuDetailViewController()
        detailController.loadData(with: item)
        detailController.modalPresentationStyle = .custom
        detailController.transitioningDelegate = self
        viewController?.present(detailController, animated: true, completion: nil)
    }
    func pushCheckoutController() {
        let checkoutController = CheckoutSceneViewController(name: nil)
        navigationController?.pushViewController(checkoutController, animated: true)
    }
}

extension HomeRouter: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presented)
    }
}
