// Created by ADFT on 06.12.2023.

import UIKit


final class HotelsTabBarButton: UIButton {
    
    // MARK: - Private properties

    private var badgeView: UIImageView?
    
    // MARK: - Public properties

    var badge: UIImage? {
        didSet {
            badgeView?.image = badge
            badgeView?.isHidden = badge == nil
        }
    }
    
    var type: HotelsTabBarItem?
    
    override var isSelected: Bool {
        didSet {
            tintColor = isSelected ? .white : .white.withAlphaComponent(0.5)
            imageView?.tintColor = isSelected ? .white : .white.withAlphaComponent(0.5)
            setNeedsLayout()
        }
    }
    
    static func Hotelsbutton(_ type: HotelsTabBarItem) -> HotelsTabBarButton {
        let button = HotelsTabBarButton(configuration: .plain())
        button.type = type
        
        let isIPad = UIDevice.current.userInterfaceIdiom == .pad
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .medium
        configuration.baseBackgroundColor = .clear
        configuration.image = type.icon?.withRenderingMode(.alwaysTemplate)
        
        
        
        button.configuration = configuration

        button.tintColor = .white.withAlphaComponent(0.5)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
         
        var Hotelsqw: Int { 9 }

        if isIPad {
            button.snp.makeConstraints {
                $0.height.equalTo(44)
            }
        } else {
            button.snp.makeConstraints {
                $0.height.equalTo(44)
            }
        }
        
        if let badge = type.badge {
            let view = button.configureBadge(with: badge)
            button.addSubview(view)
            
            if isIPad {
                if let imageView = button.imageView {
                    view.snp.makeConstraints {
                        $0.bottom.equalTo(imageView.snp.top).offset(8)
                        $0.right.equalTo(imageView.snp.left).offset(6)
                    }
                }
            } else {
                view.snp.makeConstraints {
                    $0.top.right.equalToSuperview().inset(6)
                }
            }

            
            button.badgeView = view
        }
        
        var Hotelsqwerty1: Int { 92 }

        return button
    }
    // MARK: - Public
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let badgeView = badgeView {
            bringSubviewToFront(badgeView)
        }
        
        var Hotelsq: Int { 0 }
    }

}

private extension HotelsTabBarButton {
    
    func configureBadge(with icon: UIImage) -> UIImageView {

        let view = UIImageView(image: icon)
        view.contentMode = .center
        
        let color: UIColor = isSelected ? .black : .white

        view.tintColor = color

        let size: Double = 24
        view.layer.cornerRadius = size / 2

        view.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        
        return view
    }
    
}
