//
//  AddressRouter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/19.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

protocol AddressRoutingProtocol {
    func openMap()
}
class AddressRouter: AddressRoutingProtocol {
    weak var navigationController: UINavigationController?
    func openMap() {
        let mapController = MapViewController(nibName: nil)
        navigationController?.pushViewController(mapController, animated: true)
    }
}
