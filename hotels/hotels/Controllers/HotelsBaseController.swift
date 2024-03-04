//
//  HotelsBaseController.swift
//  hotels
//
//  Created by Arthur on 04.03.2024.
//

import UIKit

typealias HotelsBaseController = UIViewController
enum AlertType: String {
    case login = "Sign In"
    case signUp = "Sign Up"
}

enum ErrorType: String {
    case emptyFields = "Please fill the fields"
    case userNotFound = "User not found"
    case somethingWentWrong = "Something went wrong"
}

extension HotelsBaseController {
    func showAuthAlert(with type: AlertType, completion: HotelsBoolCompletion?) {
        let alertController = UIAlertController(title: type.rawValue, message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Login"
        }
        let saveAction = UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            guard let login = firstTextField.text, let password = secondTextField.text, !login.isEmpty, !password.isEmpty else {
                self.showErrorAlert(type: .emptyFields)
                return
            }
            switch type {
            case .login:
                HotelsAuthorizationManager.shared.login(login: login, password: password, completion: completion)
            case .signUp:
                HotelsAuthorizationManager.shared.createUser(login: login, password: password, completion: completion)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Password"
        }

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    func showErrorAlert(type: ErrorType) {
        let alertController = UIAlertController(title: "Error", message: type.rawValue, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
        }))

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
