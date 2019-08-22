//
//  CheckoutRouter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/29.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

protocol CheckoutRoutingLogic {
   func goToUsersAddressPage()
}

class CheckoutRouter: NSObject, CheckoutRoutingLogic {
    weak var navigationController: UINavigationController?
    func goToUsersAddressPage() {
        let addressesViewController = AddressViewController(nibName: nil)
        navigationController?.pushViewController(addressesViewController, animated: true)
    }
}
