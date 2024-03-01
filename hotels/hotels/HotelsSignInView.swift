//
//  HotelsSignInView.swift
//  hotels
//
//  Created by Arthur on 27.02.2024.
//

import UIKit


final class HotelsSignInView: HotelsRoundedGradientView {
    private let titleLabel = UILabel(font: .helvetica(style: .medium, size: 18),
                                        title: "Sign in to your account to simplify registration",
                                        color: .white, lines: 0)
    private lazy var signInButton = HotelsGradientButton(type: .custom)

    var onSignIn: Hotels_VoidBlock?

    required init() {
        super.init(frame: .zero)

        Hotels_setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HotelsSignInView {
    func Hotels_setupViews() {
        addSubview(titleLabel)
        addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(onSignInButton), for: .touchUpInside)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.height.equalTo(44)
            $0.left.right.equalToSuperview().inset(25)
        }
        
        signInButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.right.left.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(24)
            $0.height.width.equalTo(59)
        }
    
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.isTitleGold = true
    }

    @objc func onSignInButton() {
        self.onSignIn?()
    }
}
