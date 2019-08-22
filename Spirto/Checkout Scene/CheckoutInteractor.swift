//
//  CheckoutInteractor.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/29.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

protocol CheckoutBusinessLogic {
    func viewCurrentCart()
    func placeOrder()
}
class CheckoutInteractor: CheckoutBusinessLogic {
    var presenter: CheckoutPresenterLogic?
    private var helper = CheckoutHelper.sharedInstance
    func viewCurrentCart() {
        presenter?.presentCartItems(items: helper.getAllItems())
        presenter?.presentTotal(total: helper.getTotal())
    }
    func placeOrder() {}
}
