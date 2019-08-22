//
//  CartItemTableViewCell.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/29.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

class CartItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var quantityInCart: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    func setup(with item: CartItem) {
        if let url = URL(string: item.item.imageUrl) {
            itemImage.setImage(from: url, with: nil)
        }
        itemTitle.text = item.item.itemName
        quantityInCart.text = "x\(item.quantity)"
        totalPrice.text = "$\(Float(item.quantity) * item.item.price)"
    }
}
