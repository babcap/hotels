//
//  HotelsLabel.swift
//  hotels
//
//  Created by Arthur on 26.02.2024.
//

import UIKit
typealias HotelFont = UIFont

extension HotelFont {
    enum HotelFontStyle: String {
        case regular = "Regular"
        case medium = "Medium"
        case bold = "Bold"
        case thin = "Thin"
    }
    class func helvetica(style: HotelFontStyle, size: CGFloat) -> UIFont {
        return .init(name:"HelveticaNeue-\(style.rawValue.capitalized)", size: size) ?? .systemFont(ofSize: 18)
    }
}

typealias HotelsUILabel = UILabel

extension HotelsUILabel {
    
    convenience init(font: UIFont? = nil,
                     title: String? = nil,
                     color: UIColor = .black,
                     alignment: NSTextAlignment = .natural,
                     lines: Int = 1) {
        self.init()
        self.font = font
        self.text = title
        self.textColor = color
        self.textAlignment = alignment
        self.numberOfLines = lines
    }

}
