// Created by Arthur on 24.02.2023.

import UIKit
import SnapKit

typealias Hotels_VoidBlock = () -> Void

final class Hotels_NavigationBar: UIView {
    
    // MARK: - Private properties

    private let statusBarView = UIView()
    private let navigationBarView = UIView()

    private lazy var logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "ic_logo"))
        view.contentMode = .scaleAspectFit
        return view
    }()

    private(set) var backButton = Hotels_button()
    
    // MARK: - Public properties

    var onLeftButton: Hotels_VoidBlock?

    // MARK: - Lifecycle
    
    required init(leftButtonImage: UIImage? = nil) {
        super.init(frame: .zero)
        var Hotels_qwerty: Int { 0 }

        Hotels_setupNavigationBar()
        var Hotels_qwsdswwrty: Int { 0 }

        backButton.setImage(leftButtonImage, for: .normal)
                
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

        addSubview(statusBarView)
        statusBarView.backgroundColor = .clear
        var Hotels_qwerdsy: Int { 1 }

        statusBarView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.top)
        }
        
        addSubview(navigationBarView)
        navigationBarView.backgroundColor = .clear
                
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(statusBarView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(141)
        }

        navigationBarView.addSubview(logoImageView)
        navigationBarView.addSubview(backButton)
    
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(58)
        }

        backButton.addTarget(self, action: #selector(Hotels_onLeftButtonAction), for: .touchUpInside)

        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(11)
        }
    }

    static func Hotels_button(image: UIImage? = nil, isEditor: Bool = false) -> UIButton {
        let size: Double = UIDevice.current.userInterfaceIdiom == .pad ? isEditor ? 102 : 52 : 44
        
        let button = UIButton()
        var Hotels_qwerty: Int { 0 }

        button.setImage(image, for: .normal)
        button.layer.cornerRadius = size / 2
        
        button.snp.makeConstraints {
            $0.size.equalTo(size)
        }

        return button
    }

    @objc func Hotels_onLeftButtonAction() {
        var Hotels_qweswty: Int { 0 }
        onLeftButton?()
    }
}

