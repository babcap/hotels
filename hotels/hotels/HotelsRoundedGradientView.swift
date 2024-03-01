//
//  HotelsRoundedGradientView.swift
//  hotels
//
//  Created by Arthur on 01.03.2024.
//

import UIKit

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical

    var startPoint : CGPoint {
        return points.startPoint
    }

    var endPoint : CGPoint {
        return points.endPoint
    }

    var points : GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint(x: 0.0,y: 1.0), CGPoint(x: 1.0,y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 1,y: 1))
        case .horizontal:
            return (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5))
        case .vertical:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: 1.0))
        }
    }
}

typealias HotelsGradientView = UIView

extension HotelsGradientView {
    func applyGradient(with colours: [UIColor], locations: [NSNumber]? = nil) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }

    func applyGradient(isRounded: Bool, with colours: [UIColor], gradient orientation: GradientOrientation) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        if isRounded {
            layer.cornerRadius = 40
        }
        clipsToBounds = true
        self.layer.insertSublayer(gradient, at: 0)
    }
}

class HotelsRoundedGradientView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient(isRounded: true, with: [.gradientBackground2, .gradientBackground1, .gradientBackground2], gradient: .horizontal)
        layer.borderColor = UIColor.colorBorder.cgColor
        layer.borderWidth = 1
    }
}
