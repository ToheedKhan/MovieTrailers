//
//  MovieFlowCoordinator.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 22/07/22.
//

import UIKit

final class MovieFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let movieModule: MovieModule
    
    init(navigationController: UINavigationController, movieModule: MovieModule) {
        self.navigationController = navigationController
        self.movieModule = movieModule
    }
    
    func start() {
        let actions = MovieListViewModelActions(showMovieDetails: showMovieDetails)

        let moviesListVC = movieModule.createMovieListViewController(actions: actions)
        navigationController?.pushViewController(moviesListVC, animated: false)
    }
    
    private func showMovieDetails(movieCellViewModel: MovieListCellViewModel) {
        let vc = movieModule.createMovieDetailViewController(with: movieCellViewModel)
        navigationController?.pushViewController(vc, animated: true)
    }    
}
