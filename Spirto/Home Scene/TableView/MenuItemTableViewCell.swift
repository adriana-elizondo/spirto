//
//  MenuItemTableViewCell.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/25.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit
import NetworkLayer

class MenuItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quantityInCart: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var lessButton: UIButton!
    private var menuItem: MenuItem.Item?
    func setup(with item: MenuItem.Item) {
        menuItem = item
        if let url = URL(string: item.imageUrl) {
            itemImage.setImage(from: url, with: nil)
        }
        title.text = item.itemName
        priceLabel.text = "$ \(item.price)"
        updateQuantity()
    }
    private func updateQuantity() {
        let quantity = CheckoutHelper.sharedInstance.quantityForItem(with: menuItem?.itemName ?? "")
        quantityInCart.text = "\(quantity)"
        lessButton.isHidden = quantity == 0
        quantityInCart.isHidden = quantity == 0
    }
    @IBAction func addToCart(_ sender: Any) {
        guard menuItem != nil else { return }
        lessButton.isHidden = false
        quantityInCart.isHidden = false
        CheckoutHelper.sharedInstance.addToCart(item: menuItem!)
        updateQuantity()
    }
    @IBAction func removeFromCart(_ sender: Any) {
        guard menuItem != nil else { return }
        CheckoutHelper.sharedInstance.deleteFromCart(item: menuItem!)
        updateQuantity()
    }
}
