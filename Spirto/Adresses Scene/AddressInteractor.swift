//
//  AddressInteractor.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/12.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

protocol AddressBusinessLogic {
    func getAddresses(for user: UserData.User)
    func createNewAddress()
}
class AddressInteractor: AddressBusinessLogic {
    var presenter: AddressPresentingProtocol?
    var worker: AddressAPIHandler?
    func getAddresses(for user: UserData.User) {
        worker?.loadAllItems(for: user, with: { (response) in})
    }
    func createNewAddress() {}
}
