//
//  MenuItemsService.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/23.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import NetworkLayer

struct MenuParameters: Codable {}
class MenuItemsService: EndpointType {
    var path: String {
        return "/menuItems"
    }
    var httpMethod: HttpMethod { return .get }
    var task: HttpTask<MenuParameters> {
        return HttpTask.request
    }
    typealias ParameterType = MenuParameters
    func getMenuItems(completion: @escaping (MenuItem.Response?, NetworkResponseError?) -> Void) {
        let router = Router<MenuItemsService, MenuItem.Response>()
        router.request(with: self) { (response, _, error) in
            DispatchQueue.main.async {
                completion(response, error)
            }
        }
    }
}
