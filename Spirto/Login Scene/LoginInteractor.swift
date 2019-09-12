//
//  LoginInteractor.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/30.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import FBSDKLoginKit

enum LoginError: Error {
    case FailedToCreateUser
}

protocol LoginuBusinessLogic {
    func isLoggedIn()
    func loginWithFacebook(with accessToken: AccessToken)
}

class LoginInteractor: LoginuBusinessLogic {
    var presenter: LoginPresenterLogic?
    var worker = LoginWorker()
    var usermanager = UserManager.sharedInstance
    func isLoggedIn() {
        if let user = usermanager.getUser(){
            worker.getUser(with: user.email) { (result) in
                switch result {
                case .success(let response):
                    self.presenter?.sayHiAndGoHome(to: response.itemReturned)
                    break
                case .failure(let error):
                    self.presenter?.presentError(with: error)
                    break
                }
            }
        }
    }
    func loginWithFacebook(with accessToken: AccessToken) {
        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, picture.type(large), birthday"]).start { (connection, result, error) in
            if (error == nil){
                if let fbdata = result as? [String: Any],
                    let email = fbdata["email"] as? String {
                    let picture = fbdata["picture"] as? [String: Any]
                    let pictureData = picture?["data"] as? [String: Any]
                    let user = User(userId: nil,
                                    name: (fbdata["name"] as? String) ?? "",
                                    phoneNumber: " - ",
                                    email: email,
                                    birthday: (fbdata["birthday"] as? String) ?? " - ",
                                    photoUrl: (pictureData?["url"] as? String) ?? " - ",
                                    addresses: nil)
                    self.worker.createNewUser(with: user, and: { (result) in
                        switch result {
                        case .success(let response):
                            self.usermanager.persistUser(user: response.itemReturned)
                            self.presenter?.presentLoginSuccess()
                            break
                        case .failure(let error):
                            self.presenter?.presentError(with: error)
                            break
                        }
                    })
                } else {
                    self.presenter?.presentError(with: LoginError.FailedToCreateUser)
                }
            }
        }
    }
}
