//
//  LoginInteractor.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/30.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import FBSDKLoginKit

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
            presenter?.sayHiAndGoHome(to: user)
        }
    }
    func loginWithFacebook(with accessToken: AccessToken) {
        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, picture.type(large), birthday"]).start { (connection, result, error) in
            if (error == nil){
                if let fbdata = result as? [String: Any] {
                    let picture = fbdata["picture"] as? [String: Any]
                    let pictureData = picture?["data"] as? [String: Any]
                    let user = User(userId: nil,
                                    name: (fbdata["name"] as? String) ?? "",
                                    phoneNumber: " - ",
                                    email: (pictureData?["email"] as? String) ?? " - ",
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
                }
            }
        }
    }
}
