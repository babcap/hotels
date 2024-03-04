//
//  HotelsProfileViewController.swift
//  hotels
//
//  Created by Arthur on 04.03.2024.
//

import UIKit

final class HotelsProfileViewController: UIViewController {
    
    private lazy var navigationBar: Hotels_NavigationBar = {
        let view = Hotels_NavigationBar()
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 171/2
        return view
    }()

    private let titleLabel = UILabel(font: .helvetica(style: .medium, size: 27),
                                     color: .white, lines: 0)
    
    private let HotelsButtonsStackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 20)
    private lazy var loginButton = HotelsGradientButton(type: .custom)
    private lazy var signUpButton = HotelsGradientButton(type: .custom)
    private lazy var deleteAccountButton = HotelsGradientButton(type: .custom)
}

private extension HotelsProfileViewController {
    func HotelsSetupViews() {
        view.addSubview(navigationBar)
        view.addSubview(profileImageView)
        view.addSubview(titleLabel)
        view.addSubview(HotelsButtonsStackView)

        navigationBar.snp.makeConstraints {
            $0.left.right.topMargin.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.left.right.topMargin.equalToSuperview()
            $0.height.width.equalTo(171)
            $0.top.equalTo(navigationBar.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().offset(25)
        }
    
        HotelsButtonsStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(25)
            $0.bottom.equalToSuperview().inset(60)
        }
    }
    func HotelssetupButtons() {
        loginButton.addTarget(self, action: #selector(onLogin), for: .touchUpInside)
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.isTitleGold = true
        signUpButton.addTarget(self, action: #selector(onSignUp), for: .touchUpInside)
        signUpButton.setTitle("Create User", for: .normal)
        signUpButton.isTitleGold = true
        deleteAccountButton.addTarget(self, action: #selector(onDelete), for: .touchUpInside)
        deleteAccountButton.setTitle("Delete Account", for: .normal)
        deleteAccountButton.gradientColors = [UIColor.colorDelete.cgColor]
        HotelsAuthorizationManager.shared.user
    }

    @objc func onLogin() {
        
    }
    
    @objc func onSignUp() {
        
    }

    @objc func onDelete() {
        func showAlertButtonTapped(_ sender: UIButton) {
                let alert = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.cancel, handler: {_ in 
                HotelsAuthorizationManager.shared.deleteUser()
            }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))

                self.present(alert, animated: true, completion: nil)
            }
    }
}
