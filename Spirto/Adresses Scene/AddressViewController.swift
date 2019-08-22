//
//  AddressViewController.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/12.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

protocol AddressDisplayLogic: class {}
class AddressViewController: UIViewController, AddressDisplayLogic {
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (navigationController?.parent as? TopTabBarController)?.tabBar?.hideMe(hide: false)
    }
    private func setup() {
        let viewController = self
        let interactor = AddressInteractor()
        let presenter = AddressPresenter()
        presenter.viewController = viewController
        interactor.presenter = presenter
        self.interactor = interactor
        let router = AddressRouter()
        router.navigationController = self.navigationController
        self.router = router
        //self.interactor?.getAddresses(for: <#T##UserData.User#>)
    }
    @IBAction func newAddress(_ sender: Any) {
        router?.openMap()
    }
}
extension AddressViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell") as? AddressTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}
