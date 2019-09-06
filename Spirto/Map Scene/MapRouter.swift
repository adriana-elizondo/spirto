//
//  MapRouter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/23.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit
protocol MapRoutingProtocol {
    func dissmissController()
}
class MapRouter: MapRoutingProtocol {
    weak var viewController: MapViewController?
    func dissmissController() {
    }
}
