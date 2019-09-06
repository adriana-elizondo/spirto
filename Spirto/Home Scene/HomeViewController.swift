//
//  HomeViewController.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/24.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

protocol HomeDisplayLogic: class {
    func displayMenuItems(with model: MenuItem.ViewModel)
    func displayCategories(with categories: [SToolbarItem], in cells: [CellData])
}
class HomeViewController: UIViewController, HomeDisplayLogic, ScrollingToolBarHandler {
    @IBOutlet weak var totalincartView: UIView!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var totalQuantityInCart: UILabel!
    @IBOutlet weak var topMenu: HorizontalScrollingToolbar!
    @IBOutlet weak var menuTableView: UITableView! {
        didSet {
            menuTableView.tableFooterView = UIView()
            menuTableView.register(UINib(nibName: "MenuItemTableViewCell",
                                         bundle: nil), forCellReuseIdentifier: "menuitemCell")
        }
    }
    //Checkout
    @IBOutlet weak var cartTotal: UILabel!
    private var viewModel: MenuItem.ViewModel?
    private var interactor: HomeBusinessLogic?
    private var router: HomeRoutingLogic?
    private var items = [MenuItem.Item]()
    private var selectedCategory = ""
    private let checkoutHelper = CheckoutHelper.sharedInstance
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Menu"
    }
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        self.interactor = interactor
        let router = HomeRouter()
        router.navigationController = self.navigationController
        router.viewController = viewController
        self.router = router
        checkoutHelper.delegate = self
        interactor.getAllItems()
        interactor.getCategories()
    }
    func displayMenuItems(with model: MenuItem.ViewModel) {
        viewModel = model
        reloadItems()
    }
    func displayCategories(with categories: [SToolbarItem], in cells: [CellData]) {
        topMenu.loadData(with: categories, cellData: cells, handler: self)
        topMenu.setCollectionViewBgcolor(color:
            UIColor.spirtoColor())
        selectedCategory = categories.first?.title ?? ""
        reloadItems()
    }
    func didTap(item: SToolbarItem) {
        selectedCategory = item.title
        reloadItems()
    }
    //actions
    private func reloadItems() {
        if let items = viewModel?.items {
            self.items = items.filter { $0.category.categoryName == selectedCategory }
        }
        menuTableView.reloadData()
    }
    @IBAction func checkout(_ sender: Any) {
        router?.pushCheckoutController()
    }
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let menuItemCell = tableView.dequeueReusableCell(withIdentifier: "menuitemCell")
            as? MenuItemTableViewCell {
            menuItemCell.setup(with: items[indexPath.row])
            return menuItemCell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.presentMenuItemDetail(with: items[indexPath.row])
    }
}
extension HomeViewController: CartUpdateProtocol {
    func itemsWereUpdated(with total: Float) {
        cartTotal.text = "$\(total)"
        checkoutButton.isEnabled = total > 0
        totalincartView.isHidden = total <= 0
        guard total > 0 else { return }
        totalincartView.scaleUpDown()
        totalQuantityInCart.text = "\(checkoutHelper.getTotalItems())"
    }
}
