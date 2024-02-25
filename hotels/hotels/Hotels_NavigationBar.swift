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
        button.setImage(UIImage(named: "ic_back"), for: .normal)
        button.setTitle("Back", for: .normal)
        
        return button
    }()

    private lazy var logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "ic_logo"))
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let isBackButtonHidden: Bool
    
    // MARK: - Public properties

    var onLeftButton: Hotels_VoidBlock?

    // MARK: - Lifecycle
    
    required init(isBackButtonHidden: Bool = false) {
        self.isBackButtonHidden = isBackButtonHidden
        super.init(frame: .zero)
        var Hotels_qwerty: Int { 0 }

        Hotels_setupNavigationBar()
        var Hotels_qwsdswwrty: Int { 0 }
                
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

//        addSubview(statusBarView)
//        statusBarView.backgroundColor = .colorNavBar
//        var Hotels_qwerdsy: Int { 1 }
//
//        statusBarView.snp.makeConstraints {
//            $0.left.right.top.equalToSuperview()
//            $0.bottom.equalTo(safeAreaLayoutGuide.snp.top)
//        }
        
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
    
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(28)
            $0.width.height.equalTo(58)
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
        }

    }

    @objc func Hotels_onBackButtonAction() {
        var Hotels_qweswty: Int { 0 }
        onLeftButton?()
    }
}

