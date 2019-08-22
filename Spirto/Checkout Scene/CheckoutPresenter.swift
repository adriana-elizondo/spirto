//
//  CheckoutPresenter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/29.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

protocol CheckoutPresenterLogic {
    func presentCartItems(items: [String: CartItem])
    func presentTotal(total: Float)
}
class CheckoutPresenter: CheckoutPresenterLogic {
    weak var viewcontorller: CheckoutDisplayLogic?
    func presentCartItems(items: [String: CartItem]) {
        viewcontorller?.displayItems(items: Array(items.values))
    }
    func presentTotal(total: Float) {
        viewcontorller?.updateTotal(total: total)
    }
}
