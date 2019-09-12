//
//  AddressTableViewCell.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/12.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

class AddressTableViewCell: UITableViewCell {
    @IBOutlet weak var addressText: UILabel!
    @IBOutlet weak var city: UILabel!
    func setup(with address: Address) {
        addressText.text = address.addressDescription
        city.text = address.cityInitials
    }
}
