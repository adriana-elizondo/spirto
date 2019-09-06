//
//  ProfileInteractor.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/31.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

protocol ProfileBusinessLogic {
    func loadUserInfo()
    func logout()
}
class ProfileInteractor: ProfileBusinessLogic {
    var helper = UserManager.sharedInstance
    var presenter: ProfilePresentingLogic?
    func loadUserInfo() {
        presenter?.presentUserData(with: helper.getUser())
    }
    func logout() {
        helper.clearUser()
        presenter?.presentLogin()
    }
}
