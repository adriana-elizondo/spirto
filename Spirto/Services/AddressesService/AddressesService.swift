//
//  AddressesService.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/12.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import NetworkLayer

struct AddressesParameters: Codable {
    var userId: String
}
class AddressesService: EndpointType {
    var parameters: AddressesParameters?
    var path: String {
        return "/addresses/"
    }
    var httpMethod: HttpMethod {return .get}
    var task: HttpTask<AddressesParameters> {
        return HttpTask.requestWithParameters(bodyParameters: nil, queryParameters: ["userId": parameters?.userId ?? 0])
    }
    typealias ParameterType = AddressesParameters
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
struct AddressParameters: Codable {
    var address: Address
}
class AddressService: EndpointType {
    var parameters: AddressParameters?
    var path: String {
        return "/address/"
    }
    var httpMethod: HttpMethod {return .post}
    var task: HttpTask<AddressParameters> {
        return HttpTask.requestWithParameters(bodyParameters: parameters, queryParameters: nil)
    }
    typealias ParameterType = AddressParameters
    func getAddresses(completion:
        @escaping (Address.Response?, NetworkResponseError?) -> Void) {
        let router = Router<AddressService, Address.Response>()
        router.request(with: self) { (response, _, error) in
            DispatchQueue.main.async {
                completion(response, error)
            }
        }
    }
}
