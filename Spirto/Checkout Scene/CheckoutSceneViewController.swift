//
//  CheckoutSceneViewController.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/28.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

protocol CheckoutDisplayLogic: class {
    func displayItems(items: [CartItem])
    func updateTotal(total: Float)
}

class CheckoutSceneViewController: UIViewController, CheckoutDisplayLogic {
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var checkoutTableView: UITableView! {
        didSet {
            checkoutTableView.tableFooterView = UIView()
            checkoutTableView.register(UINib(nibName: "CartItemTableViewCell",
                                             bundle: nil),
                                       forCellReuseIdentifier: "cartCell")
        }
    }
    private var interactor: CheckoutBusinessLogic?
    private var router: CheckoutRoutingLogic?
    private var itemsInCart = [CartItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        let viewcontroller = self
        let presenter = CheckoutPresenter()
        presenter.viewcontorller = viewcontroller
        let interactor = CheckoutInteractor()
        interactor.presenter = presenter
        self.interactor = interactor
        let router = CheckoutRouter()
        router.navigationController = self.navigationController
        self.router = router
        interactor.viewCurrentCart()
    }
    func displayItems(items: [CartItem]) {
        itemsInCart = items
        checkoutTableView.reloadData()
    }
    func updateTotal(total: Float) {
        totalPrice.text = "$\(total)"
    }
    //Actions
    @IBAction func proceed(_ sender: Any) {
        router?.goToUsersAddressPage()
    }
}

extension CheckoutSceneViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsInCart.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell")
            as? CartItemTableViewCell {
            cell.setup(with: itemsInCart[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
