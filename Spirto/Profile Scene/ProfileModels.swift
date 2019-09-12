//
//  ProfileModels.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/4.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation

struct UserData {
    struct Response: Codable {
        var itemsReturned: [User]
    }
    struct ViewModel {
        var user: User?
        init(with response: UserData.Response) {
            user = response.itemsReturned.first
        }
    }
}
struct User: Codable {
    var userId: String?
    var name: String
    var phoneNumber: String?
    var email: String
    var birthday: String?
    var photoUrl: String?
    var addresses: [Address]?
    struct Response: Codable {
        var itemReturned: User
    }
}
