//
//  CheckoutHelper.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/28.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

protocol CartUpdateProtocol: class {
    func itemsWereUpdated(with total: Float)
}

class CheckoutHelper {
    weak var delegate: CartUpdateProtocol?
    static let sharedInstance = CheckoutHelper()
    private var itemsInCart = [String: CartItem]()
    func getAllItems() -> [String: CartItem] {
        return itemsInCart
    }
    func getTotal() -> Float {
       return itemsInCart.values.reduce(0) { $0 + ($1.item.price * Float($1.quantity)) }
    }
    func getTotalItems() -> Int {
        return itemsInCart.values.reduce(0) { $0 + $1.quantity }
    }
    func quantityForItem(with name: String) -> Int {
        return itemsInCart[name]?.quantity ?? 0
    }
    func addToCart(item: MenuItem.Item) {
        if var menuitem = itemsInCart[item.itemName] {
            menuitem.addToQuantity()
            itemsInCart[item.itemName] = menuitem
            delegate?.itemsWereUpdated(with: getTotal())
            return
        }
        itemsInCart[item.itemName] = CartItem(quantity: 1, item: item)
        delegate?.itemsWereUpdated(with: getTotal())
    }
    func deleteFromCart(item: MenuItem.Item) {
        if var menuitem = itemsInCart[item.itemName] {
            if  menuitem.quantity > 1 {
                menuitem.substractFromQuantity()
                itemsInCart[item.itemName] = menuitem
                delegate?.itemsWereUpdated(with: getTotal())
                return
            }
            itemsInCart.removeValue(forKey: item.itemName)
            delegate?.itemsWereUpdated(with: getTotal())
        }
    }
}
