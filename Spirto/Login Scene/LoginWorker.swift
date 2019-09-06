//
//  LoginWorker.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/30.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import NetworkLayer

typealias LoginCompletion = (Result<UserData.Response, NetworkResponseError>) -> Void
typealias NewUserCompletion = (Result<User.Response, NetworkResponseError>) -> Void
protocol LoginAPIHandler {
    func createNewUser(with address: User, and completion: @escaping NewUserCompletion)
}
class LoginWorker: LoginAPIHandler {
    var newUserService = NewUserService()
    func createNewUser(with user: User, and completion: @escaping NewUserCompletion) {
        newUserService.parameters = user
        newUserService.createNewUser { (response, error) in
            if let response = response {
               return completion(.success(response))
            }
            
            return completion(.failure(error!))
        }
    }
}
