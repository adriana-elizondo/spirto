//
//  CheckoutModels.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/29.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

struct CartItem {
    var quantity = 0
    var item: MenuItem.Item
    mutating func addToQuantity() {
        quantity += 1
    }
    mutating func substractFromQuantity() {
        quantity -= 1
    }
}
