//
//  HotelsCreateHotelViewController.swift
//  hotels
//
//  Created by Arthur on 04.03.2024.
//

import UIKit
import Cosmos

final class HotelsCreateHotelViewController: UIViewController {

    var onCreated: Hotels_VoidBlock?
    
    private lazy var navigationBar: Hotels_NavigationBar = {
        let view = Hotels_NavigationBar()
        return view
    }()

    private let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
    private lazy var imageContriner = UIView()

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20
        view.image = UIImage(named: "ic_image_placeholder")!
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var changePhotoButton = UIButton(type: .custom)

    private lazy var nameTextField: HotelsTextField = {
        let view = HotelsTextField()
        view.attributedPlaceholder = NSAttributedString(
            string: "Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorTextFieldText,
                         .font:  HotelFont.helvetica(style: .thin, size: 24)]
        )
        view.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        return view
    }()

    private lazy var countryTextField: HotelsTextField = {
        let view = HotelsTextField()
        view.attributedPlaceholder = NSAttributedString(
            string: "Counrty",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorTextFieldText,
                         .font:  HotelFont.helvetica(style: .thin, size: 24)]
        )
        view.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        return view
    }()
    private lazy var cityTextField: HotelsTextField = {
        let view = HotelsTextField()
        view.attributedPlaceholder = NSAttributedString(
            string: "City",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorTextFieldText,
                         .font:  HotelFont.helvetica(style: .thin, size: 24)]
        )
        view.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        return view
    }()
    private lazy var addressTextField: HotelsTextField = {
        let view = HotelsTextField()
        view.attributedPlaceholder = NSAttributedString(
            string: "Address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorTextFieldText,
                         .font:  HotelFont.helvetica(style: .thin, size: 24)]
        )
        view.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        return view
    }()

    private lazy var phoneTextField: HotelsTextField = {
        let view = HotelsTextField()
        view.attributedPlaceholder = NSAttributedString(
            string: "Phone",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorTextFieldText,
                         .font:  HotelFont.helvetica(style: .thin, size: 24)]
        )
        view.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        return view
    }()

    private lazy var emailTextField: HotelsTextField = {
        let view = HotelsTextField()
        view.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorTextFieldText,
                         .font:  HotelFont.helvetica(style: .thin, size: 24)]
        )
        view.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        return view
    }()

    private lazy var conditionsView: HotelsConditionsView = {
        let view = HotelsConditionsView()
        return view
    }()

    private lazy var ratingContainer = UIView()

    private lazy var ratingLabel: UILabel = {
        let view = UILabel(font: HotelFont.helvetica(style: .medium, size: 18), title: "Rating", color: .white)
        return view
    }()
    private lazy var ratingView: CosmosView = {
        let view = CosmosView()
        view.settings.starSize = 54
        view.settings.fillMode = .full
        view.settings.starMargin = (UIScreen.main.bounds.width - (50 + 54*5))/4
        view.settings.filledImage = UIImage(named: "ic_filled_star")!
        view.settings.emptyImage = UIImage(named: "ic_empty_star")!
        return view
    }()

    private let HotelsTextFieldsStackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 20)
    private lazy var createButton = HotelsGradientButton(type: .custom)

    private lazy var imagePicker: HotelsImagePicker = {
        let imagePicker = HotelsImagePicker()
        imagePicker.delegate = self
        return imagePicker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        HotelsSetupViews()
    }
}

private extension HotelsCreateHotelViewController {
    func HotelsSetupViews() {
        view.addSubview(navigationBar)
        view.addSubview(scrollView)
        
        imageContriner.addSubview(imageView)
        ratingContainer.addSubview(ratingLabel)
        ratingContainer.addSubview(ratingView)
        imageView.addSubview(changePhotoButton)
        scrollView.addSubview(HotelsTextFieldsStackView)
        HotelsTextFieldsStackView.addArrangedSubview(imageContriner)
        HotelsTextFieldsStackView.addArrangedSubview(nameTextField)
        HotelsTextFieldsStackView.addArrangedSubview(countryTextField)
        HotelsTextFieldsStackView.addArrangedSubview(cityTextField)
        HotelsTextFieldsStackView.addArrangedSubview(addressTextField)
        HotelsTextFieldsStackView.addArrangedSubview(phoneTextField)
        HotelsTextFieldsStackView.addArrangedSubview(emailTextField)
        HotelsTextFieldsStackView.addArrangedSubview(conditionsView)
        HotelsTextFieldsStackView.addArrangedSubview(ratingContainer)
        HotelsTextFieldsStackView.addArrangedSubview(createButton)

        navigationBar.snp.makeConstraints {
            $0.left.right.topMargin.equalToSuperview()
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottomMargin.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(0.53)
        }
    
        changePhotoButton.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(16)
            $0.height.width.equalTo(25)
        }
    
        ratingLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(22)
        }

        ratingView.snp.makeConstraints {
            $0.top.equalTo(ratingLabel.snp.bottom).offset(14)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(54)
            $0.bottom.equalToSuperview().inset(16)
        }
    
        HotelsTextFieldsStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.right.equalTo(view).inset(25)
            $0.bottom.equalToSuperview().inset(40)
        }

        createButton.snp.makeConstraints {
            $0.height.equalTo(59)
        }
        HotelssetupButtons()
        hideKeyboardWhenTappedAround()
    }

    func HotelssetupButtons() {
        createButton.addTarget(self, action: #selector(onCreate), for: .touchUpInside)
        createButton.setTitle("Create", for: .normal)
        createButton.isTitleGold = true

        changePhotoButton.setImage(UIImage(named: "ic_change_photo")!.withTintColor(.white, renderingMode: .alwaysTemplate), for: .normal)
        changePhotoButton.tintColor = .white
        changePhotoButton.isUserInteractionEnabled = true
        
        changePhotoButton.addTarget(self, action: #selector(changePhoto), for: .touchUpInside)
    }

    @objc func onCreate() {

        let uuidString = "\(UUID())"
        let image = self.imageView.image ?? UIImage(named: "ic_image_placeholder")!
        HotelsPhotoManager.shared.saveImage(imageName: uuidString, image: image)

        let viewModel: HotelViewModel = .init(name: nameTextField.text ?? "",
                                              country: countryTextField.text ?? "",
                                              city: cityTextField.text ?? "",
                                              adress: addressTextField.text ?? "",
                                              starsCount: Int(ratingView.rating) ,
                                              photo: image,
                                              photoPath: uuidString,
                                              conditions: Set(self.conditionsView.selectedCells.map { HotelsConditions.allCases[$0]}))
        var defaultsHotels = [String: [String:Any]]()
        if let hotelsDict = UserDefaults.standard.value(forKey: HotelViewModel.Keys.hotels.rawValue) as? [String: [String:Any]] {
            defaultsHotels = hotelsDict
        }
        defaultsHotels[viewModel.name] = viewModel.toDict()
        UserDefaults.standard.setValue(defaultsHotels, forKey: HotelViewModel.Keys.hotels.rawValue)
        onCreated?()
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

extension HotelsCreateHotelViewController: HotelsImagePickerDelegate {

    func imagePicker(_ imagePicker: HotelsImagePicker, didSelect image: UIImage) {
        imageView.image = image
        imagePicker.dismiss()
    }

    func cancelButtonDidClick(on imageView: HotelsImagePicker) { imagePicker.dismiss() }
    func imagePicker(_ imagePicker: HotelsImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
}

