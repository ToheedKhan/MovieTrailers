//
//  Font.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import UIKit


enum FontWeight: String {
    
    case regular = "-Regular"
    case semiBold = "-DemiBold"
    case meduim = "-Medium"
    case bold = "-Bold"
    
    var weight: String { self.rawValue }
}

enum FontSize: CGFloat {
    case caption2 = 10
    case caption1 = 12
    case headline = 14
    case subtitle = 16
    case title = 20
    
    var size: CGFloat {
        if  (UIDevice.current.userInterfaceIdiom == .pad) {
            return self.rawValue * 2
        }
        return self.rawValue
    }
}

extension UIFont {
    
    private static let primaryFontFamily = "AvenirNext"
    
    static func font(weight: FontWeight = .regular, size: FontSize) -> UIFont {
        return UIFont(name: "\(primaryFontFamily)\(weight.rawValue)", size: size.size)!
    }
}
