//
//  UserManager.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/19.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

class UserManager {
    static let sharedInstance = UserManager()
    private var currentUser: User?
    private let user_key = "current_user"
    
    func persistUser(user: User) {
        let data = try? JSONEncoder().encode(user)
        UserDefaults.standard.set(data, forKey: user_key)
        self.currentUser = user
    }
    
    func getUser() -> User? {
        if currentUser == nil {
            if let userData = UserDefaults.standard.data(forKey: user_key) {
                currentUser = try? JSONDecoder().decode(User.self, from: userData)
            }
        }
        return currentUser
    }
    func clearUser() {
        UserDefaults.standard.removeObject(forKey: user_key)
    }
}
