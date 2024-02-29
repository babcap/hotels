//
//  HotelsMainArticleView.swift
//  hotels
//
//  Created by Arthur on 27.02.2024.
//

import UIKit

final class HotelsMainArticleView: UIView {
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    private let titleLabel = UILabel(font: .helvetica(style: .thin, size: 16),
                                     title: HotelsDataManager.shared.HotelsMainArticle.description,
                                        color: .white, lines: 3)
    private lazy var showButton = UIButton(type: .custom)

    var onShow: HotelsArticle_VoidBlock?

    required init() {
        super.init(frame: .zero)

        Hotels_setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HotelsMainArticleView {
    func Hotels_setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)

        addSubview(showButton)
        showButton.addTarget(self, action: #selector(onShowButton), for: .touchUpInside)

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(0.59)
            $0.left.right.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(24)
            $0.height.equalTo(44)
            $0.left.right.equalToSuperview().inset(25)
        }
        
        showButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.right.left.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(24)
            $0.height.width.equalTo(59)
        }
    
        showButton.setTitle("See more", for: .normal)
        imageView.image = HotelsDataManager.shared.HotelsMainArticle.image
    }

    @objc func onShowButton() {
        self.onShow?(HotelsDataManager.shared.HotelsMainArticle)
    }
}

