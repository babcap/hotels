//
//  HotelsHomeSearchView.swift
//  hotels
//
//  Created by Arthur on 32.02.2024.
//

import UIKit

typealias HotelsStartSearch_VoidBlock = (StartSearchViewModel) -> Void

struct StartSearchViewModel {
    var country: String?
    var startDate: String?
    var endDate: String?
}

final class HotelsHomeSearchView: HotelsRoundedGradientView, UITextFieldDelegate {
    
    private let titleLabel = UILabel(font: HotelFont.helvetica(style: .medium, size: 18), color: .white)
    private let startDateLabel = UILabel(font: HotelFont.helvetica(style: .medium, size: 18), color: .white)
    private let endDateLabel = UILabel(font: HotelFont.helvetica(style: .medium, size: 18), color: .white)
    private lazy var cityTextField: HotelsTextField = {
        let view = HotelsTextField()
        view.attributedPlaceholder = NSAttributedString(
            string: "Netherlands",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderText,
                         .font:  HotelFont.helvetica(style: .thin, size: 24)]
        )
        return view
    }()

    private lazy var startDateTextField: HotelsTextField = {
        let view = HotelsTextField()
        view.attributedPlaceholder = NSAttributedString(
            string: "12 Dec 24",
            attributes: [.foregroundColor: UIColor.placeholderText,
                         .font: HotelFont.helvetica(style: .thin, size: 24)]
        )
        view.delegate = self
        view.tag = 0
        return view
    }()

    private lazy var endDateTextField: HotelsTextField = {
        let view = HotelsTextField()
        view.attributedPlaceholder = NSAttributedString(
            string: "14 Dec 24",
            attributes: [.foregroundColor: UIColor.placeholderText,
                         .font: HotelFont.helvetica(style: .thin, size: 24)]
        )

        view.delegate = self
        view.tag = 1
        return view
    }()

    private let searchButton = HotelsSearchButton()

    private var selectedTextField: UITextField?

    private var searchVM = StartSearchViewModel()
    var onSearchTap: HotelsStartSearch_VoidBlock?
    
    required init() {
        super.init(frame: .zero)

        HotelsSetupText()
        Hotels_setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func Hotels_setupViews() {
        addSubview(titleLabel)
        addSubview(cityTextField)
        addSubview(startDateLabel)
        addSubview(endDateLabel)
        addSubview(startDateTextField)
        addSubview(endDateTextField)
        addSubview(searchButton)
        

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.height.equalTo(22)
            $0.left.right.equalToSuperview().inset(32)
        }
        cityTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(32)
            $0.height.equalTo(50)
        }
        startDateLabel.snp.makeConstraints {
            $0.top.equalTo(cityTextField.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(32)
            $0.height.equalTo(22)
            $0.right.equalTo(self.snp.centerX).inset(4)
        }
        startDateTextField.snp.makeConstraints {
            $0.top.equalTo(startDateLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(32)
            $0.height.equalTo(50)
            $0.right.equalTo(self.snp.centerX).inset(4)
        }
    
        endDateLabel.snp.makeConstraints {
            $0.top.equalTo(cityTextField.snp.bottom).offset(8)
            $0.right.equalToSuperview().inset(32)
            $0.height.equalTo(22)
            $0.left.equalTo(self.snp.centerX).offset(4)
        }
        endDateTextField.snp.makeConstraints {
            $0.top.equalTo(endDateLabel.snp.bottom).offset(8)
            $0.right.equalToSuperview().inset(32)
            $0.height.equalTo(50)
            $0.left.equalTo(self.snp.centerX).offset(4)
        }
        searchButton.snp.makeConstraints {
            $0.top.equalTo(endDateTextField.snp.bottom).offset(30)
            $0.right.left.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview().inset(26)
        }
        searchButton.onSearch = {
            self.HotelsonSearchButton()
        }
    }

    private func HotelsSetupText() {
        self.titleLabel.text = "Country"
        self.startDateLabel.text = "Start"
        self.endDateLabel.text = "Finish"
    }

    func HotelsonSearchButton() {
        searchVM.country = cityTextField.text
        onSearchTap?(searchVM)
    }
}
