//
//  MovieDetailCoordinator.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 02/09/22.
//
import UIKit

final class MovieDetailCoordinator : Coordinator {
    weak var parentCoordinator: MovieListCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var selectedMovieCellVM: MovieListCellViewModel!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let movieDetailVC = MovieDetailDI().createMovieDetailViewController(selectedMovieCellViewModel: selectedMovieCellVM)
        self.navigationController.pushViewController(movieDetailVC, animated: true)
    }
}
