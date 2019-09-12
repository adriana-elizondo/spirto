//
//  AddressInteractor.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/12.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

protocol AddressBusinessLogic {
    func getAddresses()
}
class AddressInteractor: AddressBusinessLogic {
    var presenter: AddressPresentingProtocol?
    private let worker = AddressWorker()
    func getAddresses() {
        if let user = UserManager.sharedInstance.getUser() {
            worker.loadAllItems(for: user, with: { (response) in
                switch response{
                case .success(let response):
                    self.presenter?.presentUserAddresses(with: response)
                    break
                case .failure(_):
                    break
                }
            })
        }
    }
}
