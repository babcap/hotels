//
//  HotelsWelcomeArticleView.swift
//  hotels
//
//  Created by Arthur on 26.02.2024.
//

import UIKit

final class HotelsWelcomeArticleView: UIView {
    private let titleLabel = UILabel(font: .helvetica(style: .bold, size: 40), title: HotelsDataManager.shared.HotelsWelcomeArticleTitle, color: .white, lines: 1)
    private let subtitleLabel = UILabel(font: .helvetica(style: .thin, size: 18), title: HotelsDataManager.shared.HotelsWelcomeArticleDesctiption, color: .white, lines: 1)
    private lazy var showButton = HotelsGradientButton(type: .custom)

    var onShowWelcome: Hotels_VoidBlock?

    required init() {
        super.init(frame: .zero)

        Hotels_setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HotelsWelcomeArticleView {
    func Hotels_setupViews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(showButton)
        showButton.addTarget(self, action: #selector(onShowButton), for: .touchUpInside)

        showButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.bottom.equalTo(subtitleLabel.snp.bottom)
            $0.height.width.equalTo(59)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.height.equalTo(49)
            $0.left.equalToSuperview().inset(25)
            $0.right.equalToSuperview().inset(75)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.height.equalTo(22)
            $0.left.equalToSuperview().inset(25)
            $0.right.equalToSuperview().inset(75)
            $0.bottom.equalToSuperview().inset(16)
        }
    
        showButton.setImage(UIImage(named: "ic_welcome"), for: .normal)
    }

    @objc func onShowButton() {
        self.onShowWelcome?()
    }
}
