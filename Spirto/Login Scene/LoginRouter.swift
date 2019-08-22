//
//  LoginRouter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/30.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

protocol LoginRoutingProtocol {
    func goHome()
}

class LoginRouter: LoginRoutingProtocol {
    weak var navigationController: UINavigationController?
    func goHome() {
        navigationController?.pushViewController(STabBarController(nibName: nil), animated: true)
    }
}
