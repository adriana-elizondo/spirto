//
//  ProfileRouter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/9/6.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileRoutingProtocol{
    func goToLogin()
    func goToUsersAddressPage()
}
class ProfileRouter: ProfileRoutingProtocol{
    weak var navigationController: UINavigationController?
    func goToUsersAddressPage() {
        let addressesViewController = AddressViewController(nibName: nil)
        navigationController?.pushViewController(addressesViewController, animated: true)
    }
    func goToLogin() {
        AppNavigationHelper.sharedInstance.navigationController?.popToRootViewController(animated: true)
    }
}
