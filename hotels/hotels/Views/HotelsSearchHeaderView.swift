//
//  HotelsSearchHeaderView.swift
//  hotels
//
//  Created by Arthur on 01.03.2024.
//

import UIKit
import Cosmos

final class HotelsSearchHeaderView: UIView {
    var onSearchTap: HotelsStartSearch_VoidBlock?
    var viewModel: SearchViewModel
    
    private lazy var headerContainer = UIView()
    private lazy var searchContainer = HotelsFilledGradientView()
    
    private lazy var cityLabel: UILabel = {
        let view = UILabel(font: HotelFont.helvetica(style: .medium, size: 18), color: .white)
        view.isUserInteractionEnabled = false
        return view
    }()
    private lazy var countryLabel: UILabel = {
        let view = UILabel(font: HotelFont.helvetica(style: .medium, size: 18), color: .white)
        view.isUserInteractionEnabled = false
        return view
    }()
    private lazy var startDateLabel: UILabel = {
        let view = UILabel(font: HotelFont.helvetica(style: .medium, size: 18), color: .white)
        view.isUserInteractionEnabled = false
        return view
    }()
    private lazy var endDateLabel: UILabel = {
        let view = UILabel(font: HotelFont.helvetica(style: .medium, size: 18), color: .white)
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var countryTextField: HotelsTextField = {
        let view = HotelsTextField()
        view.attributedPlaceholder = NSAttributedString(
            string: "Netherlands",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorTextFieldText,
                         .font:  HotelFont.helvetica(style: .thin, size: 24)]
        )
        return view
    }()

    private lazy var cityTextField: HotelsTextField = {
        let view = HotelsTextField()
        view.attributedPlaceholder = NSAttributedString(
            string: "Amsterdam",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorTextFieldText,
                         .font:  HotelFont.helvetica(style: .thin, size: 24)]
        )
        return view
    }()

    private lazy var startDateTextField: HotelsTextField = {
        let view = HotelsTextField()
        view.attributedPlaceholder = NSAttributedString(
            string: "12 Dec 24",
            attributes: [.foregroundColor: UIColor.colorTextFieldText,
                         .font: HotelFont.helvetica(style: .thin, size: 24)]
        )
        view.tag = 0
        return view
    }()

    private lazy var endDateTextField: HotelsTextField = {
        let view = HotelsTextField()
        view.attributedPlaceholder = NSAttributedString(
            string: "14 Dec 24",
            attributes: [.foregroundColor: UIColor.colorTextFieldText,
                         .font: HotelFont.helvetica(style: .thin, size: 24)]
        )

        view.tag = 1
        return view
    }()

    private lazy var ratingLabel: UILabel = {
        let view = UILabel(font: HotelFont.helvetica(style: .medium, size: 18), title: "Rating", color: .white)
        view.isUserInteractionEnabled = false
        return view
    }()
    private lazy var ratingView: CosmosView = {
        let view = CosmosView()
        view.settings.starSize = 54
        view.settings.fillMode = .full
        view.settings.starMargin = (UIScreen.main.bounds.width - (50 + 54*5))/4
        view.settings.filledImage = UIImage(named: "ic_filled_star")!
        view.settings.emptyImage = UIImage(named: "ic_empty_star")!
        view.didFinishTouchingCosmos = {
            self.viewModel.rating = Int($0)
        }
        return view
    }()

    private lazy var conditionsView = HotelsConditionsView()

    private lazy var searchButton = HotelsSearchButton()
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorSeparator
        return view
    }()

    required init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        HotelsSetupText()
        Hotels_setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func Hotels_setupViews() {
        addSubview(headerContainer)
        headerContainer.addSubview(searchContainer)
        searchContainer.addSubview(countryLabel)
        searchContainer.addSubview(countryTextField)
        searchContainer.addSubview(cityLabel)
        searchContainer.addSubview(cityTextField)
        searchContainer.addSubview(startDateLabel)
        searchContainer.addSubview(endDateLabel)
        searchContainer.addSubview(startDateTextField)
        searchContainer.addSubview(endDateTextField)

        headerContainer.addSubview(ratingLabel)
        headerContainer.addSubview(ratingView)
        headerContainer.addSubview(conditionsView)
        headerContainer.addSubview(searchButton)
        headerContainer.addSubview(separatorView)

        headerContainer.snp.makeConstraints() {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(self.snp.bottom).priority(.high)
        }
    
        searchContainer.snp.makeConstraints() {
            $0.top.left.right.equalToSuperview()
        }

        countryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.height.equalTo(22)
            $0.left.right.equalToSuperview().inset(32)
        }
        countryTextField.snp.makeConstraints {
            $0.top.equalTo(countryLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(32)
            $0.height.equalTo(50)
        }

        cityLabel.snp.makeConstraints {
            $0.top.equalTo(countryTextField.snp.bottom).offset(18)
            $0.height.equalTo(22)
            $0.left.right.equalToSuperview().inset(32)
        }

        cityTextField.snp.makeConstraints {
            $0.top.equalTo(cityLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(32)
            $0.height.equalTo(50)
        }

        startDateLabel.snp.makeConstraints {
            $0.top.equalTo(cityTextField.snp.bottom).offset(18)
            $0.left.equalToSuperview().inset(32)
            $0.height.equalTo(22)
            $0.right.equalTo(self.snp.centerX).inset(4)
        }

        startDateTextField.snp.makeConstraints {
            $0.top.equalTo(startDateLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(32)
            $0.height.equalTo(50)
            $0.right.equalTo(self.snp.centerX).inset(4)
            $0.bottom.equalToSuperview().inset(36)
        }

        endDateLabel.snp.makeConstraints {
            $0.top.equalTo(cityTextField.snp.bottom).offset(18)
            $0.right.equalToSuperview().inset(32)
            $0.height.equalTo(22)
            $0.left.equalTo(self.snp.centerX).offset(5)
        }

        endDateTextField.snp.makeConstraints {
            $0.top.equalTo(endDateLabel.snp.bottom).offset(8)
            $0.right.equalToSuperview().inset(32)
            $0.height.equalTo(50)
            $0.left.equalTo(self.snp.centerX).offset(5)
            $0.bottom.equalToSuperview().inset(36)
        }

        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(searchContainer.snp.bottom).offset(32)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(22)
        }

        ratingView.snp.makeConstraints {
            $0.top.equalTo(ratingLabel.snp.bottom).offset(14)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(54)
        }

        conditionsView.snp.makeConstraints {
            $0.top.equalTo(ratingView.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
        }

        searchButton.snp.makeConstraints {
            $0.top.equalTo(conditionsView.snp.bottom).offset(26)
            $0.right.left.equalToSuperview()
        }

        separatorView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(searchButton.snp.bottom).offset(26)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(26)
        }


        searchButton.onSearch = {
            self.onSearchTap?(.init(country: self.countryTextField.text ?? "", rating: self.viewModel.rating, conditions: (Set(self.conditionsView.selectedCells.map { HotelsConditions.allCases[$0]}))))
        }
    }

    private func HotelsSetupText() {
        self.countryLabel.text = "Country"
        self.cityLabel.text = "City"
        self.startDateLabel.text = "Start"
        self.endDateLabel.text = "Finish"
        setup(with: viewModel)
    }

    private func setup(with viewModel: SearchViewModel) {
        self.countryTextField.text = viewModel.country
        self.startDateTextField.text = viewModel.startDate
        self.endDateTextField.text = viewModel.endDate
    }
}
