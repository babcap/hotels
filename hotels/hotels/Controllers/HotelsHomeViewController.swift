//
//  ViewController.swift
//  hotels
//
//  Created by Arthur on 24.02.2024.
//

import UIKit

typealias HotelsArticle_VoidBlock = (HotelsArticleViewModel) -> Void

class HotelsHomeViewController: UIViewController {

    private lazy var navigationBar: Hotels_NavigationBar = {
        let view = Hotels_NavigationBar(isBackButtonHidden: true)
        return view
    }()

    private let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()

    private let contentStackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 20)
    private lazy var welcomeArticleView = HotelsWelcomeArticleView()
    private lazy var searchView: HotelsHomeSearchView = {
        let view = HotelsHomeSearchView()
        return view
    } ()
    private lazy var hotelsSignInView = HotelsSignInView()
    private lazy var hotelsMainArticleView = HotelsMainArticleView()
    private lazy var subArticlesView = UIView()
    private lazy var firstArticleView = HotelsSubArticleView(model: HotelsDataManager.shared.HotelsFirstArticle)
    private lazy var secondArticleView = HotelsSubArticleView(model: HotelsDataManager.shared.HotelsSecondArticle)

    override func viewDidLoad() {
        super.viewDidLoad()
        HotelsSetupViews()
    }

    private func HotelsSetupViews() {
        view.addSubview(navigationBar)
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)

        setupArticleViews()
        contentStackView.addArrangedSubview(welcomeArticleView)
        contentStackView.addArrangedSubview(searchView)
        contentStackView.addArrangedSubview(hotelsSignInView)
        contentStackView.addArrangedSubview(hotelsMainArticleView)
        contentStackView.addArrangedSubview(subArticlesView)

        navigationBar.snp.makeConstraints {
            $0.left.right.topMargin.equalToSuperview()
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottomMargin.equalToSuperview()
        }

        contentStackView.snp.makeConstraints {
            $0.left.right.equalTo(view).inset(25)
            $0.top.bottom.equalToSuperview()
        }

        searchView.onSearchTap = {
            self.onSearch(model: $0)
        }

        welcomeArticleView.onShowWelcome = {
            self.showWelcomeArticle()
        }

        hotelsSignInView.onSignIn = {
            self.HotelsSignIn()
        }
        
        hotelsSignInView.onSignUp = {
            self.HotelsSignUp()
        }

        hotelsMainArticleView.onShow = {
            self.showArticle(model: $0)
        }

        firstArticleView.onShow = {
            self.showArticle(model: $0)
        }

        secondArticleView.onShow = {
            self.showArticle(model: $0)
        }
    }

    private func setupArticleViews() {
        subArticlesView.addSubview(firstArticleView)
        subArticlesView.addSubview(secondArticleView)

        firstArticleView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.bottom.top.equalToSuperview()
            $0.right.equalTo(subArticlesView.snp.centerX).inset(5)
        }

        secondArticleView.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.bottom.top.equalToSuperview()
            $0.left.equalTo(subArticlesView.snp.centerX).offset(5)
        }
    }
}

extension HotelsHomeViewController {
    func onSearch(model: SearchViewModel) {
        let vc = HotelsSearchViewController(viewModel: model, isFromHomeScreen: true)
        self.navigationController?.pushViewController(vc, animated: false)
    }

    func showWelcomeArticle() {
        showArticle(model: HotelsDataManager.shared.HotelsWelcomeArticle)
    }

    func HotelsSignIn() {
        showAuthAlert(with: .login) { result in
            guard result else {
                self.showErrorAlert(type: .userNotFound)
                return
            }
            self.hotelsSignInView.removeFromSuperview()
        }
    }

    func HotelsSignUp() {
        showAuthAlert(with: .signUp) { result in
            guard result else {
                self.showErrorAlert(type: .somethingWentWrong)
                return
            }
            self.hotelsSignInView.removeFromSuperview()
        }
    }

    func showArticle(model: HotelsArticleViewModel) {
        let vc = HotelsArticleDetailsViewController(viewModel: model)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

