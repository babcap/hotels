//
//  HotelsSubArticleView.swift
//  hotels
//
//  Created by Arthur on 28.02.2024.
//

import UIKit

final class HotelsSubArticleView: HotelsRoundedGradientView {
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()

    private let titleLabel = UILabel(font: .helvetica(style: .thin, size: 16),
                                     title: HotelsDataManager.shared.HotelsMainArticle.description,
                                        color: .white, lines: 1)
    private lazy var showButton = HotelsGradientButton(type: .custom)
    private var viewModel: HotelsArticleViewModel

    var onShow: HotelsArticle_VoidBlock?

    required init(model: HotelsArticleViewModel) {
        self.viewModel = model
        super.init(frame: .zero)

        Hotels_setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HotelsSubArticleView {
    func Hotels_setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(showButton)

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(0.59)
            $0.left.right.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(14)
            $0.height.equalTo(24)
            $0.left.equalToSuperview().offset(12)
            $0.right.equalToSuperview().inset(12)
        }

        showButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.left.equalToSuperview().offset(12)
            $0.right.bottom.equalToSuperview().inset(12)
            $0.height.equalTo(59)
        }

        showButton.addTarget(self, action: #selector(onShowButton), for: .touchUpInside)
        showButton.setTitle("See more", for: .normal)
        imageView.image = viewModel.image
        titleLabel.text = viewModel.description
    }

    @objc func onShowButton() {
        self.onShow?(viewModel)
    }
}
