//
//  ProfilePresenter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/31.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

protocol ProfilePresentingLogic {
    func presentUserData(with user: User?)
    func presentLogin()
}
class ProfilePresenter: ProfilePresentingLogic {
    weak var viewController: ProfileDisplayLogic?
    func presentUserData(with user: User?) {
        viewController?.displayProfileData(user: user)
    }
    func presentLogin() {
        viewController?.displayLogin()
    }
}
