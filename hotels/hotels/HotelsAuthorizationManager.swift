//
//  HotelsAuthorizationManager.swift
//  hotels
//
//  Created by Arthur on 04.03.2024.
//

import UIKit

typealias HotelsBoolCompletion = ((Bool)->Void)

struct HotelsUser {
    let login: String
    let password: String
    let imagePath: String
    
    enum Keys: String {
        case login
        case password
        case imagePath
    }
    
    func toDictionary() -> [String: String] {
        [Keys.login.rawValue: login,
         Keys.password.rawValue: password,
         Keys.imagePath.rawValue: imagePath
        ]
    }
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

    func login(login: String, password: String, completion: HotelsBoolCompletion?) {
        guard let user = UserDefaults.standard.value(forKey: login) as? [String:String],
              let storedPassword = user[HotelsUser.Keys.password.rawValue] else {
            completion?(false)
            return
        }
        self.user = .init(login: login, password: storedPassword, imagePath: user[HotelsUser.Keys.imagePath.rawValue] ?? "")
        completion?(true)
    }

    func createUser(login: String, password: String, completion: HotelsBoolCompletion?) {
        let uuid = UUID()
        let user = HotelsUser(login: login,
                              password: password,
                              imagePath: "\(uuid)")
        self.user = user
        UserDefaults.standard.set(user.toDictionary(), forKey: login)
        completion?(true)
    }

    func createTestUser() {
        let log = "testadmin"
        guard let user = UserDefaults.standard.value(forKey: log) as? [String:String] else {
            let uuid = UUID().uuidString
            let user = HotelsUser(login: log,
                                  password: log,
                                  imagePath: uuid)
            UserDefaults.standard.set(user.toDictionary(), forKey: log)
            HotelsPhotoManager.shared.saveImage(imageName: uuid, image: UIImage(named: "ic_test_profile")!)
            return
        }
    }

    func deleteUser(compltion: HotelsBoolCompletion?) {
        guard let user else {
            compltion?(false)
            return
        }
        UserDefaults.standard.removeObject(forKey: user.login)
        self.user = nil
        compltion?(true)
    }
}
