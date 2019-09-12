//
//  AddressPresenter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/12.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

protocol AddressPresentingProtocol {
    func presentUserAddresses(with addresses: Addresses.Response)
}
class AddressPresenter: AddressPresentingProtocol {
    weak var viewController: AddressDisplayLogic?
    func presentUserAddresses(with addresses: Addresses.Response) {
        viewController?.displayAddresses(with: Addresses.ViewModel(with: addresses))
    }
}
