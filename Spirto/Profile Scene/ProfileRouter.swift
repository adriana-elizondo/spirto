//
//  ProfileRouter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/9/6.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

protocol ProfileRoutingProtocol{
    func goToLogin()
}
class ProfileRouter: ProfileRoutingProtocol{
    func goToLogin() {
        AppNavigationHelper.sharedInstance.navigationController?.popToRootViewController(animated: true)
    }
}
