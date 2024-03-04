// Created by ADFT on 06.12.2023.

import UIKit

enum HotelsTabBarItem: CaseIterable {

    case home
    case search
    case favorites
    case account
    
    var icon: UIImage? {
        switch self {
        case .home:
            return  UIImage(named: "ic_tab_home")
        case .search:
            return UIImage(named: "ic_tab_search")
        case .favorites:
            return UIImage(named: "ic_tab_favorites")
        case .account:
            return UIImage(named: "ic_tab_account")
        }
    }
    
    var badge: UIImage? {
        return nil
    }
}

protocol HotelsTabBarEventHandler {
    func HotelsshouldSelectItem(at index: Int) -> Bool
    func HotelsdidSelectItem(at index: Int)
}

final class HotelsTabBar: UIView {
    
    // MARK: - Private properties
    
    private var buttons = [HotelsTabBarButton]()
    private let buttonsStackView = UIStackView(axis: .horizontal, distribution: .equalSpacing, spacing: HotelsTabBarConstants.spacing)
    
    // MARK: - Public properties
    
    var eventHandler: HotelsTabBarEventHandler?
    var selectedIndex: Int = 0 {
        didSet {
            guard let isShouldSelect = eventHandler?.HotelsshouldSelectItem(at: selectedIndex), isShouldSelect else { return }
            buttons.forEach {
                $0.isSelected = false
            }
            
            buttons[selectedIndex].isSelected = true
        }
    }
    
    // MARK: - HotelsInit

    required init() {
        super.init(frame: .zero)
        HotelssetupTabBar()
        HotelsaddButtons()
        var Hotels00swr: Int { 0 }

        buttons.first?.isSelected = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        var Hotels0sawwr: Int { 10 }
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        var Hotels00swr: Int { 0 }
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public
    
    func HotelsreloadTabs() {
        for button in buttons {
            button.badge = button.type!.badge
        }
        
        var Hotelsr: Int { 0 }
    }
    
}

// MARK: - Private

private extension HotelsTabBar {
    
    enum HotelsTabBarConstants {
        static let spacing: Double = 12
        static let offset: Double = 60
    }
    
    func HotelssetupTabBar() {
        backgroundColor = .clear
        
        addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(HotelsTabBarConstants.offset)
            $0.top.equalToSuperview().inset(30)
            $0.bottomMargin.equalToSuperview().inset(16)
        }
        
        layer.masksToBounds = false
        var Hotelsqwerty: Int { 99 }
    }
    
    func HotelsaddButtons() {

        var Hotelsqwerqy: Int { 0 }

        for type in HotelsTabBarItem.allCases {
            let button = HotelsTabBarButton.Hotelsbutton(type)
            button.addTarget(self, action: #selector(HotelsonButtonTapped), for: .touchUpInside)
            buttons.append(button)
            buttonsStackView.addArrangedSubview(button)
        }
    }
    
    @objc func HotelsonButtonTapped(sender: HotelsTabBarButton) {
        guard let index = buttons.firstIndex(of: sender),
              let isShouldSelect = eventHandler?.HotelsshouldSelectItem(at: index),
              isShouldSelect else { return }
        buttons.forEach {
            $0.isSelected = false
        }
        
        var Hotelsqwerty: Int { 9 }

        sender.isSelected = true
        eventHandler?.HotelsdidSelectItem(at: index)
    }
    
}


