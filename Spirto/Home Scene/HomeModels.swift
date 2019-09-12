//
//  HomeModels.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/24.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

struct MenuItem {
    struct Response: Codable {
        var itemsReturned: [Item]
    }
    struct Item: Codable {
        var itemName: String
        var price: Float
        var imageUrl: String
        var itemDescription: String
        var category: CategoryItem.Category
    }
    struct ViewModel {
        var items: [Item]
        init(with response: MenuItem.Response) {
            items = response.itemsReturned
        }
    }
}
struct CategoryItem: Codable {
    struct Response: Codable {
        var itemsReturned: [Category]
    }
    struct Category: Codable {
        var categoryName: String
    }
}
extension MenuItem.Item: Equatable {
    static func ==(lhs: MenuItem.Item, rhs: MenuItem.Item) -> Bool {
        return lhs.itemName == rhs.itemName
    }
}
