//
//  AddressWorker.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/12.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import NetworkLayer

typealias AddressCompletion = (Result<Addresses.Response, NetworkResponseError>) -> Void
protocol AddressAPIHandler {
    func loadAllItems(for user: User, with completion: @escaping AddressCompletion)
    func createNewAddress(with address: Address)
}
class AddressWorker: AddressAPIHandler {
    let addressesService = AddressesService()
    func loadAllItems(for user: User,
                      with completion: @escaping (Result<Addresses.Response, NetworkResponseError>) -> Void) {
        addressesService.parameters = AddressesParameters(userId: user.userId ?? "")
        addressesService.getAddresses(completion: { (response, error) in
            guard error == nil else { completion(.failure(error!)); return }
            guard response != nil else { completion(.failure(.parsingError(error: error))); return}
            completion(.success(response!))
        })
    }
    func createNewAddress(with address: Address) {}
}
