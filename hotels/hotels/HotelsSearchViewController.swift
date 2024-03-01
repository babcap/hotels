//
//  HotelsSearchViewController.swift
//  hotels
//
//  Created by Arthur on 01.03.2024.
//

import UIKit

final class HotelsSearchViewController: UIViewController {

    private let viewModel: StartSearchViewModel

    private lazy var navigationBar: Hotels_NavigationBar = {
        let view = Hotels_NavigationBar()
        return view
    }()

    private lazy var searchHeaderView: HotelsSearchHeaderView = {
        let headerView = HotelsSearchHeaderView()
        return headerView
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
//        tableView.register()
        tableView.canCancelContentTouches = false
        
        tableView.sectionHeaderTopPadding = 0
        tableView.bounces = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()

    required init(viewModel: StartSearchViewModel) {
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
        HotelsSetupViews()
    }

    private func HotelsSetupViews() {
        view.addSubview(navigationBar)
        view.addSubview(tableView)

        navigationBar.snp.makeConstraints {
            $0.left.right.topMargin.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        navigationBar.onLeftButton = {
            self.navigationController?.popViewController(animated: false)
        }
    }
}


extension HotelsSearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
 
}

// MARK: - UITableViewDataSource

extension HotelsSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = HotelsSearchHeaderView()
        return headerView
    }
}
