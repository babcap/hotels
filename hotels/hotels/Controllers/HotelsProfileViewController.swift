//
//  HotelsProfileViewController.swift
//  hotels
//
//  Created by Arthur on 04.03.2024.
//

import UIKit

final class HotelsProfileViewController: UIViewController {
    
    private lazy var navigationBar: Hotels_NavigationBar = {
        let view = Hotels_NavigationBar(isBackButtonHidden: true)
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "ic_user")!
        view.clipsToBounds = true
        return view
    }()

    private lazy var changePhotoButton = UIButton(type: .custom)

    private let titleLabel = UILabel(font: .helvetica(style: .medium, size: 27),
                                     color: .white, alignment: .center, lines: 0)
    
    private let HotelsButtonsStackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 20)
    private lazy var loginButton = HotelsGradientButton(type: .custom)
    private lazy var signUpButton = HotelsGradientButton(type: .custom)
    private lazy var deleteAccountButton = HotelsGradientButton(type: .custom)

    private lazy var imagePicker: HotelsImagePicker = {
        let imagePicker = HotelsImagePicker()
        imagePicker.delegate = self
        return imagePicker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        HotelsSetupViews()
        setupUser()
    }
}

private extension HotelsProfileViewController {
    func HotelsSetupViews() {
        view.addSubview(navigationBar)
        view.addSubview(profileImageView)
        view.addSubview(titleLabel)
        view.addSubview(HotelsButtonsStackView)
        view.addSubview(changePhotoButton)
        HotelsButtonsStackView.addArrangedSubview(loginButton)
        HotelsButtonsStackView.addArrangedSubview(signUpButton)
        HotelsButtonsStackView.addArrangedSubview(deleteAccountButton)

        navigationBar.snp.makeConstraints {
            $0.left.right.topMargin.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.height.width.equalTo(171)
            $0.top.equalTo(navigationBar.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    
        changePhotoButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.left.equalTo(profileImageView.snp.right).offset(16)
            $0.height.width.equalTo(25)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(25)
            $0.right.equalToSuperview().inset(25)
        }
    
        HotelsButtonsStackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(25)
            $0.right.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(60)
        }

        loginButton.snp.makeConstraints {
            $0.height.equalTo(59)
        }
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(59)
        }
        deleteAccountButton.snp.makeConstraints {
            $0.height.equalTo(59)
        }
        profileImageView.layer.cornerRadius = 171/2
        HotelssetupButtons()
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
        deleteAccountButton.gradientColors = [UIColor.colorDelete.cgColor, UIColor.colorDelete.cgColor, UIColor.colorDelete.cgColor, UIColor.colorDelete.cgColor]
        changePhotoButton.setImage(UIImage(named: "ic_change_photo")!.withTintColor(.white, renderingMode: .alwaysTemplate), for: .normal)
        changePhotoButton.tintColor = .white
        
        changePhotoButton.addTarget(self, action: #selector(changePhoto), for: .touchUpInside)
    }

    func setupUser() {
        profileImageView.isHidden = !HotelsAuthorizationManager.shared.isLoggedIn
        titleLabel.isHidden = !HotelsAuthorizationManager.shared.isLoggedIn
        changePhotoButton.isHidden = !HotelsAuthorizationManager.shared.isLoggedIn
        deleteAccountButton.isHidden = !HotelsAuthorizationManager.shared.isLoggedIn
        loginButton.isHidden = HotelsAuthorizationManager.shared.isLoggedIn
        signUpButton.isHidden = HotelsAuthorizationManager.shared.isLoggedIn
        if let user = HotelsAuthorizationManager.shared.user {
            if let image = HotelsPhotoManager.shared.loadImageFromDiskWith(fileName: user.imagePath) {
                profileImageView.image = image
            }
            titleLabel.text = user.login
        }
    }

    @objc func onLogin() {
        showAuthAlert(with: .login) {
            guard $0 else {
                self.showErrorAlert(type: .userNotFound)
                return
            }
            self.setupUser()
        }
    }

    @objc func onSignUp() {
        showAuthAlert(with: .signUp) {
            guard $0 else {
                self.showErrorAlert(type: .somethingWentWrong)
                return
            }
            self.setupUser()
        }
    }

    @objc func onDelete() {
        let alert = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.cancel, handler: {_ in
            HotelsAuthorizationManager.shared.deleteUser(compltion: {
                guard $0 else {
                    self.showErrorAlert(type: .userNotFound)
                    return
                }
                self.setupUser()
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    @objc func changePhoto() {

        let actionSheet = UIAlertController(title: "Source", message: "Take a picture or select a photo", preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler:{(action:UIAlertAction) in
            self.imagePicker.cameraAsscessRequest()
        }))

        actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler:{(action:UIAlertAction) in
            self.imagePicker.photoGalleryAsscessRequest()
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension HotelsProfileViewController: HotelsImagePickerDelegate {

    func imagePicker(_ imagePicker: HotelsImagePicker, didSelect image: UIImage) {
        guard let user = HotelsAuthorizationManager.shared.user else {
            showErrorAlert(type: .somethingWentWrong)
            return
        }
        profileImageView.image = image
        HotelsPhotoManager.shared.saveImage(imageName: user.imagePath, image: image)
        imagePicker.dismiss()
    }

    func cancelButtonDidClick(on imageView: HotelsImagePicker) { imagePicker.dismiss() }
    func imagePicker(_ imagePicker: HotelsImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
}
