//
//  HotelsCreateHotelButtonView.swift
//  hotels
//
//  Created by Arthur on 04.03.2024.
//

import UIKit

final class HotelsCreateHotelButtonView: UIView {

    var onCreate: Hotels_VoidBlock?
    private lazy var container = UIView()
    private lazy var createButton = HotelsGradientButton(type: .custom)

    
    required init() {
        super.init(frame: .zero)
        Hotels_setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension HotelsCreateHotelButtonView {
    func Hotels_setupViews() {
        addSubview(container)
        container.addSubview(createButton)
        createButton.addTarget(self, action: #selector(onCreateButton), for: .touchUpInside)
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        createButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.bottom.equalToSuperview().inset(30)
            $0.left.right.equalToSuperview()
            $0.height.width.equalTo(59)
        }
        createButton.setTitle("Create a new hotel", for: .normal)
    }

    @objc func onCreateButton() {
        self.onCreate?()
    }
}
