//
//  HomeWorker.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/24.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import NetworkLayer

typealias HomeCompletion = (Result<MenuItem.Response, NetworkResponseError>) -> Void

protocol HomeAPIHandler {
    func loadAllItems(with completion: @escaping HomeCompletion)
}

class HomeWorker: HomeAPIHandler {
    let menuItemsService = MenuItemsService()
    let categoryService = CategoryService()
    func loadAllItems(with completion: @escaping (Result<MenuItem.Response, NetworkResponseError>) -> Void) {
        menuItemsService.getMenuItems { (response, error) in
            guard error == nil else { completion(.failure(error!)); return }
            guard response != nil else { completion(.failure(.parsingError)); return}
            completion(.success(response!))
        }
    }
    func loadCategories(with completion: @escaping (Result<CategoryItem.Response, NetworkResponseError>) -> Void) {
        categoryService.getCategories { (response, error) in
            guard error == nil else { completion(.failure(error!)); return }
            guard response != nil else { completion(.failure(.parsingError)); return}
            completion(.success(response!))
        }
    }
}
