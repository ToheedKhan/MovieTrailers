//
//  UIViewController+Extension.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 14/07/22.
//

import UIKit

extension ViewControllerUtilities {
    
    static func initialize(on storyboard: Storyboard) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as? Self else {
            fatalError("Could not find view controller with identifier \(String(describing: Self.self))")
        }
        return controller
    }
    
}

extension UIViewController: ViewControllerUtilities {}
