//
//  HotelsAuthorizationManager.swift
//  hotels
//
//  Created by Arthur on 04.03.2024.
//

import Foundation

struct HotelsUser {
    let login: String
    let password: String
    let imagePath: String
}

final class HotelsAuthorizationManager {
    private init() {}
    static let shared = HotelsAuthorizationManager()
    var user: HotelsUser?
}

extension HotelsAuthorizationManager {
    var isLoggedIn: Bool {
        user != nil
    }

    func createUser(login: String, password: String) {
        
    }

    func deleteUser() {
        
    }
}
