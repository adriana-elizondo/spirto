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
typealias UserCompletion = (Result<User.Response, NetworkResponseError>) -> Void
protocol LoginAPIHandler {
    func createNewUser(with address: User, and completion: @escaping UserCompletion)
    func getUser(with email: String, and completion: @escaping UserCompletion)
}
class LoginWorker: LoginAPIHandler {
    var newUserService = NewUserService()
    var queryUserService = QueryUserService()
    func getUser(with email: String, and completion: @escaping UserCompletion) {
        queryUserService.parameters = email
        queryUserService.getUser { (response, error) in
            if let response = response {
                return completion(.success(response))
            }
            
            return completion(.failure(error!))
        }
    }
    func createNewUser(with user: User, and completion: @escaping UserCompletion) {
        newUserService.parameters = user
        newUserService.createNewUser { (response, error) in
            if let response = response {
                return completion(.success(response))
            }
            
            return completion(.failure(error!))
        }
    }
}
