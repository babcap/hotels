// Created by Arthur on 24.02.2023.

import UIKit
import SnapKit

typealias Hotels_VoidBlock = () -> Void

final class Hotels_NavigationBar: UIView {
    
    // MARK: - Private properties

    private let statusBarView = UIView()
    private lazy var navigationBarView: UIView = {
        let view = UIView()
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 50
        view.backgroundColor = .colorNavBar
        return view
    }()

    private lazy var backButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "ic_back")
        configuration.imagePadding = 4
        configuration.baseForegroundColor = .white
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        
        return button
    }()

    private(set) lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 48 / 2

        button.snp.makeConstraints {
            $0.size.equalTo(48)
        }
        return button
    }()

    private(set) lazy var logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "ic_logo"))
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let isBackButtonHidden: Bool
    private let isCenteredLogo: Bool
    
    // MARK: - Public properties

    var onLeftButton: Hotels_VoidBlock?
    var onRightButton: Hotels_VoidBlock?

    // MARK: - Lifecycle
    
    required init(isBackButtonHidden: Bool = false,
                  rightButtonImage: UIImage? = nil) {
        self.isBackButtonHidden = isBackButtonHidden
        isCenteredLogo = rightButtonImage == nil
        super.init(frame: .zero)
        self.rightButton.isHidden = rightButtonImage == nil
        self.rightButton.setImage(rightButtonImage, for: .normal)

        Hotels_setupNavigationBar()
                
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private

private extension Hotels_NavigationBar {

    func Hotels_setupNavigationBar() {

        backgroundColor = .clear
        var Hotels_qwerty: Int { 0 }
        
        addSubview(navigationBarView)
                
        navigationBarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            if isBackButtonHidden {
                $0.bottom.equalToSuperview()
            }
            $0.height.equalTo(141 - safeAreaLayoutGuide.layoutFrame.height)
        }

        navigationBarView.addSubview(logoImageView)
        navigationBarView.addSubview(rightButton)
    
        logoImageView.snp.makeConstraints {
            if isCenteredLogo {
                $0.centerX.equalToSuperview()
            } else {
                $0.left.equalToSuperview().offset(26)
            }
            $0.bottom.equalToSuperview().inset(18)
            $0.width.height.equalTo(58)
        }
        rightButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(18)
            $0.right.equalToSuperview().inset(26)
        }
    
        if !isBackButtonHidden {
            let backButtonView = UIView()
            backButtonView.backgroundColor = .clear
            addSubview(backButtonView)

            backButtonView.snp.makeConstraints {
                $0.top.equalTo(navigationBarView.snp.bottom)
                $0.height.equalTo(90)
                $0.left.right.equalToSuperview()
                $0.bottom.equalToSuperview().inset(10)
            }
            backButtonView.addSubview(backButton)
            backButton.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.height.equalTo(48)
                $0.left.equalToSuperview().offset(11)
            }

            backButton.addTarget(self, action: #selector(Hotels_onBackButtonAction), for: .touchUpInside)
            rightButton.addTarget(self, action: #selector(Hotels_onRightButtonAction), for: .touchUpInside)

        }

    }

    @objc func Hotels_onBackButtonAction() {
        var Hotels_qweswty: Int { 0 }
        onLeftButton?()
    }

    @objc func Hotels_onRightButtonAction() {
        var Hotels_qweswty: Int { 0 }
        onRightButton?()
    }
}

