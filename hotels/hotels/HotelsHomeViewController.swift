//
//  ViewController.swift
//  hotels
//
//  Created by Arthur on 24.02.2024.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        HotelsSetupViews()
    }


    private func HotelsSetupViews() {
        view.addSubview(navigationBar)
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        searchView.onSearchTap = { viewModel in
            debugPrint(viewModel)
        }
        contentStackView.addArrangedSubview(welcomeArticleView)
        contentStackView.addArrangedSubview(searchView)
        contentStackView.addArrangedSubview(hotelsSignInView)
        
        
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
    }

    func onSearch(model: StartSearchViewModel) {
        
    }

    func showWelcomeArticle() {
        
    }

    func HotelsSignIn() {
        
    }
}


