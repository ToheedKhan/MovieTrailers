//
//  Coordinator.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 16/08/22.
//

import UIKit

protocol Coordinator : AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] {get set}

    func start()
}
