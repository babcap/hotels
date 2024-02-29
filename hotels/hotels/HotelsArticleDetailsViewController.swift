//
//  HotelsArticleDetailsViewController.swift
//  hotels
//
//  Created by Arthur on 29.02.2024.
//

import UIKit

final class HotelsArticleDetailsViewController: UIViewController {

    private let viewModel: HotelsArticleViewModel

    private lazy var navigationBar: Hotels_NavigationBar = {
        let view = Hotels_NavigationBar()
        return view
    }()
    private let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
    private let contentStackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 16)

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()

    private let titleLabel = UILabel(font: .helvetica(style: .regular, size: 20),
                                     color: .white, lines: 0)

    
    required init(viewModel: HotelsArticleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private init() {
        fatalError("Use init(with:)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = viewModel.image
        titleLabel.text = viewModel.description
        
        navigationBar.onLeftButton = {
            self.navigationController?.popViewController(animated: false)
        }

        HotelsSetupViews()
    }

}

extension HotelsArticleDetailsViewController {
    func HotelsSetupViews() {
        view.addSubview(navigationBar)
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(titleLabel)

        navigationBar.snp.makeConstraints {
            $0.left.right.topMargin.equalToSuperview()
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottomMargin.equalToSuperview()
        }
        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
            $0.left.right.equalTo(view).inset(25)
            
        }
        imageView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(0.53)
        }
    }
}
