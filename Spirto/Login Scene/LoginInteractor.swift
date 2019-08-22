//
//  LoginInteractor.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/30.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

protocol LoginuBusinessLogic {
    func loginWithFacebook(with completion: @escaping (Bool) -> Void)
}

class LoginInteractor: LoginuBusinessLogic {
    var presenter: LoginPresenterLogic?
    func loginWithFacebook(with completion: @escaping (Bool) -> Void) {}
}
