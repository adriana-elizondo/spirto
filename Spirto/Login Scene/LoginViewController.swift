//
//  LoginViewController.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/30.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

protocol LoginDisplayLogic: class {}

class LoginViewController: UIViewController, LoginDisplayLogic {
    private var router: LoginRoutingProtocol?
    private var interactor: LoginuBusinessLogic?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        let viewcontroller = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        presenter.viewcontroller = viewcontroller
        interactor.presenter = presenter
        self.interactor = interactor
        let router = LoginRouter()
        router.navigationController = self.navigationController
        self.router = router
    }
    @IBAction func loginTapped(_ sender: Any) {
        router?.goHome()
    }
}
