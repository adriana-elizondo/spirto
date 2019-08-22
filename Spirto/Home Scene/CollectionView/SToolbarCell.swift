//
//  SToolbarCell.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/29.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

class SToolbarCell: UICollectionViewCell, HorizontalScrollbarContainable {
    @IBOutlet weak var itemTitle: UILabel!
    func setup(with title: String) {
        itemTitle.text = title
    }
}
