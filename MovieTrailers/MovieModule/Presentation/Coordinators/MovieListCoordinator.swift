//
//  MovieListCoordinator.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 02/09/22.
//

import UIKit

final class MovieListCoordinator : NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let movieListVC = MovieListDI(networkManager: AppDI().networkManager).createMovieListViewController()
        movieListVC.movieListCoordinator = self
        self.navigationController.pushViewController(movieListVC, animated: false)
    }
    
    func navigateToMovieDetailVC(viewModel: MovieListCellViewModel) {
        let movieDetailCoordinator = MovieDetailCoordinator(navigationController: navigationController)
        movieDetailCoordinator.parentCoordinator = self
        movieDetailCoordinator.selectedMovieCellVM = viewModel
        movieDetailCoordinator.start()
    }
}
