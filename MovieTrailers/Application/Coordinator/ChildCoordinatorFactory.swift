//
//  ChildCoordinatorFactory.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 16/08/22.
//

import UIKit

enum ChildCoordinatorType {
    case movieList
    case movieDetail
}

final class ChildCoordinatorFactory {
    static func create(with _navigationController: UINavigationController,
                       type: ChildCoordinatorType) -> ChildCoordinator {
        switch(type) {
        case .movieList:
            return MovieListChildCoordinator(with: _navigationController)
        case .movieDetail:
            return MovieDetailChildCoordinator(with: _navigationController)
        }
        
    }
}
