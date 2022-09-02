//
//  Colors.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import UIKit

private enum Colors: String {
    case headerBG = "headerBG"
    case headerLight = "headerLight"
    case primary = "primary"
    case primaryBG = "primaryBG"
    case primaryText = "primaryText"
    case secondary = "secondary"
    case secondaryText = "secondaryText"
    case primaryTheme = "primaryTheme"
    
    var color: UIColor {
        return UIColor(named: self.rawValue)!
    }
}
 
protocol ColorProvider {
    var headerBGColor: UIColor { get }
    var headerLightColor: UIColor { get }
    var primaryColor: UIColor { get }
    var primaryBGColor: UIColor { get }
    var primaryTextColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var secondaryTextColor: UIColor { get }
    var primaryTheme: UIColor { get }
}
 
extension ColorProvider {
    var headerBGColor: UIColor { return Colors.headerBG.color }
    var headerLightColor: UIColor { return Colors.headerLight.color }
    var primaryColor: UIColor { return Colors.primary.color }
    var primaryBGColor: UIColor { return Colors.primaryBG.color }
    var primaryTextColor: UIColor { return Colors.primaryText.color }
    var secondaryColor: UIColor { return Colors.secondary.color }
    var secondaryTextColor: UIColor { return Colors.secondaryText.color }
    var primaryTheme: UIColor { return Colors.primaryTheme.color }
}
