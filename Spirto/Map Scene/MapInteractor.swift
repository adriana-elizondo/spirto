//
//  MapInteractor.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/26.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import CoreLocation
protocol MapBusinessLogic {
    func saveAddress(with address: String, city: String, coordinates: CLLocationCoordinate2D)
}
class MapInteractor: MapBusinessLogic {
    let worker = AddressWorker()
    var presenter: MapPresentingProtocol?
    
    func saveAddress(with address: String, city: String, coordinates: CLLocationCoordinate2D) {
        let address = Address(addressDescription: address,
                              city: city,
                              latitude: coordinates.latitude,
                              longitude: coordinates.longitude)
        worker.createNewAddress(with: address) { (result) in
            switch result{
            case .success(let response):
                self.presenter?.presentAddressSavedSuccessfully(with: response.itemReturned)
                break
            case .failure(_):
                break
            }
        }
    }
}
