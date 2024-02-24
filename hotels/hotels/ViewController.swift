//
//  ViewController.swift
//  hotels
//
//  Created by Arthur on 24.02.2024.
//

import UIKit

class ViewController: UIViewController {

    private lazy var navigationBar: Hotels_NavigationBar = {
        let view = Hotels_NavigationBar(leftButtonImage: UIImage(named:"ic_back"))
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        HotelsSetupViews()
    }


    private func HotelsSetupViews() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.left.right.topMargin.equalToSuperview()
        }
    }
}

