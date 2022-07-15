//
//  Colors.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import UIKit

struct DesignSystem {
    
    enum Colors: String {
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
}
