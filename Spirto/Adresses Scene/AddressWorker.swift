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
    func createNewAddress(with address: Address, with completion:
        @escaping (Result<Address.Response, NetworkResponseError>) -> Void)
}
class AddressWorker: AddressAPIHandler {
    let addressesService = AddressesService()
    let singleAddressService = AddressService()
    func loadAllItems(for user: User,
                      with completion: @escaping (Result<Addresses.Response, NetworkResponseError>) -> Void) {
        addressesService.parameters = user.email
        addressesService.getAddresses(completion: { (response, error) in
            guard error == nil else { completion(.failure(error!)); return }
            guard response != nil else { completion(.failure(.parsingError(error: error))); return}
            completion(.success(response!))
        })
    }
    func createNewAddress(with address: Address, with completion:
        @escaping (Result<Address.Response, NetworkResponseError>) -> Void) {
        singleAddressService.parameters = AddressPostParameters(address: address, userEmail: UserManager.sharedInstance.getUser()?.email ?? "")
        singleAddressService.createNewAddress { (response, error) in
            guard error == nil else { completion(.failure(error!)); return }
            guard response != nil else { completion(.failure(.parsingError(error: error))); return}
            completion(.success(response!))
        }
    }
}
