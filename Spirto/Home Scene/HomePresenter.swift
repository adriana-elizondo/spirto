//
//  HomePresenter.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/24.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import NetworkLayer

protocol HomePresenterLogic {
    func presentMenuItems(with response: MenuItem.Response)
    func presentCategories(with response: CategoryItem.Response)
    func presentError(with error: NetworkResponseError)
}

class HomePresenter: HomePresenterLogic {
    weak var viewController: HomeDisplayLogic?
    func presentMenuItems(with response: MenuItem.Response) {
        viewController?.displayMenuItems(with: MenuItem.ViewModel(with: response))
    }
    func presentCategories(with response: CategoryItem.Response) {
        let items = response.itemsReturned.map { SToolbarItem($0.categoryName, "defaultToolbarCell")}
        let cells = [CellData("SToolbarCell", "defaultToolbarCell")]
       viewController?.displayCategories(with: items, in: cells)
    }
    func presentError(with error: NetworkResponseError) {
        print(error)
    }
}
