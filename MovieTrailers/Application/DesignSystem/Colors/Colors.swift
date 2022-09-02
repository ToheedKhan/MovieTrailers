//
//  Colors.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import UIKit

private enum Colors: String {
    case primary = "primary"
    case secondary = "secondary"
    case darkLine = "darkLine"
    case pinkColor = "pinkColor"
    case bgColor = "bgColor"
    case blueColor = "blueColor"
    case headerBGColor = "headerBGColor"
    
    var color: UIColor {
        return UIColor(named: self.rawValue)!
    }
}
 
protocol ColorProvider {
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var darkLineColor: UIColor { get }
    var pinkColor: UIColor { get }
    var bgColor: UIColor { get }
    var blueColor: UIColor { get }
    var headerBGColor: UIColor { get }
}
 
extension ColorProvider {
    var primaryColor: UIColor { return Colors.primary.color }
    var secondaryColor: UIColor { return Colors.secondary.color }
    var darkLineColor: UIColor { return Colors.darkLine.color }
    var pinkColor: UIColor { return Colors.pinkColor.color }
    var bgColor: UIColor { return Colors.bgColor.color }
    var blueColor: UIColor { return Colors.blueColor.color }
    var headerBGColor: UIColor { return Colors.headerBGColor.color }
}

