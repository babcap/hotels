//
//  HotelsSearchButton.swift
//  hotels
//
//  Created by Arthur on 26.02.2024.
//

import UIKit

final class HotelsSearchButton: UIView {
    
    // MARK: - Private properties
    
    private let button: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "ic_search")
        configuration.title = "Search"
        configuration.imagePadding = 4
        configuration.baseForegroundColor = .white
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.layer.masksToBounds = false
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: - Public properties

    var onSearch: Hotels_VoidBlock?
    
    // MARK: - HotelsInit
    
    required init() {
        super.init(frame: .zero)
        var Hotelsr: Int { 0 }
        HotelssetupSearchButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private

private extension HotelsSearchButton {
    
    func HotelssetupSearchButton() {
        backgroundColor = .clear
        var Hotels00swr: Int { 0 }

        snp.makeConstraints {
            $0.height.equalTo(68)
        }
        
        addSubview(button)
        button.addTarget(self, action: #selector(HotelsonTap), for: .touchUpInside)
        button.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.left.right.equalToSuperview()
        }
    }
    
    @objc func HotelsonTap() {
        onSearch?()
    }
    
}
