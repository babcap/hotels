//
//  HotelsGradientButton.swift
//  hotels
//
//  Created by Arthur on 29.02.2024.
//

import UIKit

final class HotelsGradientButton: UIButton {
    var isTitleGold: Bool = false

    var gradientColors: [CGColor] = []
    var backgroundGradientColors: [CGColor] = []
    private let gradientLayer = CAGradientLayer()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if isTitleGold {
            let titleColors: [UIColor] = [.gradient1, .gradient2, .gradient3, .gradient4]
            gradientColors = titleColors.map({ $0.cgColor })
        }
        let backgroundColors: [UIColor] = [.gradientBackground1, .gradientBackground2]
        backgroundGradientColors = backgroundColors.map({ $0.cgColor })
        if let gradientColor = UIColor.drawGradientColor(in: rect, colors: gradientColors) {
            self.setTitleColor(gradientColor, for: .normal)
        }
        
        setupBackGroundGradient(rect)
    }

    func setupBackGroundGradient(_ rect: CGRect) {
        gradientLayer.frame = rect

        gradientLayer.colors = backgroundGradientColors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)

        layer.insertSublayer(gradientLayer, at: 0)
        layer.borderColor = UIColor.colorBorderGradient.cgColor
        layer.borderWidth = 0.5

        layer.cornerRadius = rect.height / 2
        clipsToBounds = true
    }
}

class GradientLabel: UILabel {
    var gradientColors: [CGColor] = []

    override func drawText(in rect: CGRect) {
        if let gradientColor = UIColor.drawGradientColor(in: rect, colors: gradientColors) {
            self.textColor = gradientColor
        }
        super.drawText(in: rect)
    }
}

extension UIColor {
    static func drawGradientColor(in rect: CGRect, colors: [CGColor]) -> UIColor? {
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.saveGState()
        defer { currentContext?.restoreGState() }

        let size = rect.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: colors as CFArray,
                                        locations: nil) else { return nil }

        let context = UIGraphicsGetCurrentContext()
        context?.drawLinearGradient(gradient,
                                    start: CGPoint.zero,
                                    end: CGPoint(x: size.width, y: 0),
                                    options: [])
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let image = gradientImage else { return nil }
        return UIColor(patternImage: image)
    }
}
