//
//  AddressPresenter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/12.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

protocol AddressPresentingProtocol {}
class AddressPresenter: AddressPresentingProtocol {
    weak var viewController: AddressDisplayLogic?
}
