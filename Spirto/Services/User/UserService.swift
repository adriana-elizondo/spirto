//
//  UserService.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/26.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import NetworkLayer


class NewUserService: EndpointType {
    var parameters: User?
    var path: String {
        return "/user"
    }
    var httpMethod: HttpMethod {return .post}
    var task: HttpTask<User> {
        return HttpTask.requestWithParameters(bodyParameters: parameters, queryParameters: nil)
    }
    typealias ParameterType = User
    func createNewUser(completion: @escaping (User.Response?, NetworkResponseError?) -> Void) {
        let router = Router<NewUserService, User.Response>()
        router.request(with: self) { (response, _, error) in
            DispatchQueue.main.async {
                completion(response, error)
            }
        }
    }
}
