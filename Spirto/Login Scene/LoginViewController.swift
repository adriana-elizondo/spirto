//
//  LoginViewController.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/30.
//  Copyright © 2019 adriana. All rights reserved.
//

import FacebookLogin
import FBSDKLoginKit
import Foundation
import UIKit

protocol LoginDisplayLogic: class {
    func goHomeAfterSuccessfulLogin()
    func sayHiAndGoHome(to user: User)
    func displayError(with error: Error)
}

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
        interactor.isLoggedIn()
    }
    func sayHiAndGoHome(to user: User) {
        print("Hello \(user.name)")
        self.router?.goHome()
    }
    func goHomeAfterSuccessfulLogin() {
        self.router?.goHome()
    }
    func displayError(with error: Error) {
        print(error)
    }
    @IBAction func loginTapped(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .email, .userBirthday],
                           viewController: self) { (result) in
            switch result {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(_, _, let accessToken):
                self.interactor?.loginWithFacebook(with: accessToken)
            }
        }
    }
}
