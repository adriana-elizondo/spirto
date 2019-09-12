//
//  AddressesService.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/12.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import NetworkLayer

class AddressesService: EndpointType {
    var parameters: String?
    var path: String {
        return "/addressess"
    }
    var httpMethod: HttpMethod {return .get}
    var task: HttpTask<String> {
        return HttpTask.requestWithParameters(bodyParameters: nil,
                                              queryParameters: nil,
                                              pathParameters: [parameters ?? ""])
    }
    typealias ParameterType = String
    func getAddresses(completion:
        @escaping (Addresses.Response?, NetworkResponseError?) -> Void) {
        let router = Router<AddressesService, Addresses.Response>()
        router.request(with: self) { (response, _, error) in
            DispatchQueue.main.async {
                completion(response, error)
            }
        }
    }
}

struct AddressPostParameters: Codable {
    var address: Address
    var userEmail: String
}

class AddressService: EndpointType {
    var parameters: AddressPostParameters?
    var path: String {
        return "/address"
    }
    var httpMethod: HttpMethod {return .post}
    var task: HttpTask<AddressPostParameters> {
        return HttpTask.requestWithParameters(bodyParameters: parameters,
                                              queryParameters: nil,
                                              pathParameters: nil)
    }
    typealias ParameterType = AddressPostParameters
    func createNewAddress(completion:
        @escaping (Address.Response?, NetworkResponseError?) -> Void) {
        let router = Router<AddressService, Address.Response>()
        router.request(with: self) { (response, _, error) in
            DispatchQueue.main.async {
                completion(response, error)
            }
        }
    }
}
