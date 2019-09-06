//
//  LoginPresenter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/30.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

protocol LoginPresenterLogic {
    func sayHiAndGoHome(to user: User)
    func presentError(with error: Error)
    func presentLoginSuccess()
}

class LoginPresenter: LoginPresenterLogic {
    weak var viewcontroller: LoginDisplayLogic?
    func sayHiAndGoHome(to user: User) {
        viewcontroller?.sayHiAndGoHome(to: user)
    }
    func presentLoginSuccess() {
        viewcontroller?.goHomeAfterSuccessfulLogin()
    }
    func presentError(with error: Error) {
        viewcontroller?.displayError(with: error)
    }
}
