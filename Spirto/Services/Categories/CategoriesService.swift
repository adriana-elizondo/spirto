//
//  CategoriesService.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/29.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import NetworkLayer

struct CategoryParameters: Codable {}

class CategoryService: EndpointType {
    var path: String {
        return "/categories"
    }
    var httpMethod: HttpMethod {return .get}
    var task: HttpTask<MenuParameters> {
        return HttpTask.request
    }
    typealias ParameterType = MenuParameters
    func getCategories(completion:
        @escaping (CategoryItem.Response?, NetworkResponseError?) -> Void) {
        let router = Router<CategoryService, CategoryItem.Response>()
        router.request(with: self) { (response, _, error) in
            DispatchQueue.main.async {
                completion(response, error)
            }
        }
    }
}
