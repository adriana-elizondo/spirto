//
//  MenuDetailViewController.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/4.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

class MenuDetailViewController: UIViewController {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    private var item: MenuItem.Item?
    func loadData(with item: MenuItem.Item) {
        self.item = item
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItemData()
    }
    private func loadItemData() {
        guard item != nil else {return}
        if let url = URL(string: item!.imageUrl) {
            itemImage.setImage(from: url, with: nil)
        }
        itemTitle.text = item?.itemName
        itemDescription.text = item?.itemDescription
    }
}
