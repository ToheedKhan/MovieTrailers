//
//  ViewControllerUtilities.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 14/07/22.
//

import UIKit

enum Storyboard: String {
    case main = "Movie"
}


/**
 
 ViewController Utility where we can add another functionality for UIViewController
 
 */

protocol ViewControllerUtilities where Self: UIViewController {
    static func initialize(on storyboard: Storyboard) -> Self
}
