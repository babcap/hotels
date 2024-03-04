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

extension HotelsBaseController {
    func showAuthAlert(with type: AlertType, completion: HotelsBoolCompletion?) {
        let alertController = UIAlertController(title: type.rawValue, message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Login"
        }
        let saveAction = UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            guard let login = firstTextField.text, let password = secondTextField.text else {
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
}
