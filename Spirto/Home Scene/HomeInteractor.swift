//
//  HomeInteractor.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/24.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

protocol HomeBusinessLogic {
    func getAllItems()
    func getCategories()
    func addItemToCart()
}
class HomeInteractor: HomeBusinessLogic {
    let worker = HomeWorker()
    var presenter: HomePresenterLogic?
    func getAllItems() {
        worker.loadAllItems { (result) in
            switch result {
            case .success(let response):
                self.presenter?.presentMenuItems(with: response)
            case .failure(let error):
                //TODO: handle error type
                self.presenter?.presentError(with: error)
            }
        }
    }
    func getCategories() {
        worker.loadCategories { (result) in
            switch result {
            case .success(let response):
                self.presenter?.presentCategories(with: response)
            case .failure(let error):
                //TODO: handle error type
                self.presenter?.presentError(with: error)
            }
        }
    }
    func addItemToCart() {}
}
