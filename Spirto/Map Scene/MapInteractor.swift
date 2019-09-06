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
    func saveAddress(with address: String, city: String, coordinates: CLLocationCoordinate2D) {}
}
