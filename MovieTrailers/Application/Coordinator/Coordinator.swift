//
//  Coordinator.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 16/08/22.
//

import UIKit

protocol Coordinator : AnyObject {
    var navigationController: UINavigationController { get set }
}
protocol Test: Coordinator {
    
}
protocol ParentCoordinator : Coordinator {
    var navigationController: UINavigationController { get set }
    
    var childCoordinators: [ChildCoordinator] {get set}
    
    func configureRootViewController()
    
    func removeChildCoordinator(child: ChildCoordinator)
}


protocol ChildCoordinator : Coordinator {
    var parentCoordinator: ParentCoordinator? {get set}
    func configureChildViewController()
    func passParameter(value: Decodable)
}

extension ChildCoordinator {
    func passParameter(value: Decodable) { }
}
