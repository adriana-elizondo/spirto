//
//  AddressViewController.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/12.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

protocol AddressDisplayLogic: class {
    func displayAddresses(with viewModel: Addresses.ViewModel)
}
class AddressViewController: UIViewController, AddressDisplayLogic {
    @IBOutlet weak var createAddressButton: UIButton!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var adressTableView: UITableView! {
        didSet {
            adressTableView.tableFooterView = UIView()
            adressTableView.register(
                UINib(nibName: "AddressTableViewCell",
                      bundle: nil), forCellReuseIdentifier: "addressCell")
        }
    }
    private var interactor: AddressBusinessLogic?
    private var viewModel: Addresses.ViewModel?
    private var router: AddressRoutingProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Address"
        self.interactor?.getAddresses()
    }
    private func setup() {
        let viewController = self
        let interactor = AddressInteractor()
        let presenter = AddressPresenter()
        presenter.viewController = viewController
        interactor.presenter = presenter
        self.interactor = interactor
        let router = AddressRouter()
        router.viewController = self
        self.router = router
    }
    @IBAction func newAddress(_ sender: Any) {
        router?.openMap()
    }
    //Protocol
    func displayAddresses(with viewModel: Addresses.ViewModel) {
        self.viewModel = viewModel
        adressTableView.reloadData()
    }
}
extension AddressViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell") as? AddressTableViewCell {
            if let address = viewModel?.items[indexPath.row] {
                cell.setup(with: address)
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
