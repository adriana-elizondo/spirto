//
//  MapPresenter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/9/9.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

protocol MapPresentingProtocol {
    func presentAddressSavedSuccessfully(with address: Address)
}
class MapPresenter: MapPresentingProtocol {
    weak var viewController: MapDisplayProtocol?
    func presentAddressSavedSuccessfully(with address: Address) {
        viewController?.displayAddressSavedSuccessfully()
    }
}
