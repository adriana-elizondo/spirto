//
//  AddressModels.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/12.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import MapKit
struct Address: Codable {
    var addressDescription: String
    var city: String
    var latitude: Double
    var longitude: Double
    struct Response: Codable {
        var itemReturned: Address
    }
}
struct Addresses {
    struct Response: Codable {
        var itemsReturned: [Address]
    }
    struct ViewModel {
        var items: [Address]
        init(with response: Addresses.Response) {
            items = response.itemsReturned
        }
    }
}
extension Address {
    var cityInitials: String {
        guard city.count > 0 else { return "" }
        return String(city.dropLast(city.count - 2))
    }
    func getMapPlacemark() -> MKPlacemark? {
        return MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
    }
}
