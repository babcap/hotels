//
//  HotelsStackView.swift
//  hotels
//
//  Created by Arthur on 25.02.2024.
//

import UIKit

typealias HotelsStackView = UIStackView
extension HotelsStackView {
    
    convenience init(
        axis: NSLayoutConstraint.Axis = .horizontal,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        layoutMargins: UIEdgeInsets? = nil,
        spacing: CGFloat = 0
    ) {
        self.init()
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        if let layoutMargins = layoutMargins {
            self.layoutMargins = layoutMargins
            isLayoutMarginsRelativeArrangement = true
        }
    }
    
}
