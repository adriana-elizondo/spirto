//
//  ProfileViewController.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/31.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileDisplayLogic: class {
    func displayProfileData(user: User?)
    func displayLogin()
}
class ProfileViewController: UIViewController, ProfileDisplayLogic {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    private var user: User?
    private var interactor: ProfileBusinessLogic?
    private var router: ProfileRoutingProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        let viewcontroller = self
        let presenter = ProfilePresenter()
        presenter.viewController = viewcontroller
        let interactor = ProfileInteractor()
        interactor.presenter = presenter
        let router = ProfileRouter()
        router.navigationController = navigationController
        self.router = router
        self.interactor = interactor
        interactor.loadUserInfo()
    }
    //Protocol functions
    func displayProfileData(user: User?) {
        guard let user = user else { return }
        self.user = user
        if let url = URL(string: user.photoUrl ?? "") {
         profileImage.setImage(from: url, with: nil)
        }
        
        helloLabel.text = "Hello \(user.name)!"
        phoneLabel.text = user.phoneNumber
        nameLabel.text = user.name
        birthdayLabel.text = user.birthday
        emailLabel.text = user.email
    }
    func displayLogin() {
        router?.goToLogin()
    }
    //Action
    @IBAction func manageAddresses(_ sender: Any) {
        router?.goToUsersAddressPage()
    }
    @IBAction func logout(_ sender: Any) {
        interactor?.logout()
    }
}
