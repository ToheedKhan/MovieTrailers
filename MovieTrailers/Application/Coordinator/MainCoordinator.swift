//
//  MainCoordinator.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 16/08/22.
//

import UIKit

class MainCoordinator : ParentCoordinator {
    var childCoordinators: [ChildCoordinator] = [ChildCoordinator]()
    
    var navigationController: UINavigationController
    
    init(with _navigationController: UINavigationController) {
        self.navigationController = _navigationController
    }
    
    func configureRootViewController() {
        let movieListChildCoordinator = ChildCoordinatorFactory.create(with: self.navigationController, type: .movieList)
        
        childCoordinators.append(movieListChildCoordinator)
        movieListChildCoordinator.parentCoordinator = self
        movieListChildCoordinator.configureChildViewController()
    }
    
    func removeChildCoordinator(child: ChildCoordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if (coordinator === child) {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
