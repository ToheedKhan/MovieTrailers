//
//  Storyboarded.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 02/09/22.
//

import Foundation
import UIKit

enum Storyboard: String {
    case main = "Movie"
}

protocol Storyboarded where Self: UIViewController {
    static func initialize(on storyboard: Storyboard) -> Self
}

extension Storyboarded {
    static func initialize(on storyboard: Storyboard) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as? Self else {
            fatalError("Could not find view controller with identifier \(String(describing: Self.self))")
        }
        return controller
    }
}
