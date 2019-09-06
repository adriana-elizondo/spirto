//
//  Extensions.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/23.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import NetworkLayer

extension EndpointType {
    var baseUrl: URL {
        return URL(string: "http://192.168.1.196:8080")!
    }
}
