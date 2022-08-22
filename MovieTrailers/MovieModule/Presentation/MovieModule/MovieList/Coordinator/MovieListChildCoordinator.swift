//
//  MovieListChildCoordinator.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 16/08/22.
//
import UIKit

final class MovieListChildCoordinator : ChildCoordinator {
    weak var parentCoordinator: ParentCoordinator?
    
    var navigationController: UINavigationController
    
    init(with _navigationController : UINavigationController){
        self.navigationController = _navigationController
    }
    
    func configureChildViewController() {
        let movieListVC = MovieListDI(networkManager: AppDI().networkManager).createMovieListViewController()
        movieListVC.movieListChildCoordinator = self
        self.navigationController.pushViewController(movieListVC, animated: false)
    }
    
    func navigateToMovieDetailVC(viewModel: MovieListCellViewModel) {
        guard let navigationController = parentCoordinator?.navigationController else { return }
        let movieDetailChildCoordinator = ChildCoordinatorFactory.create(with: navigationController, type: .movieDetail)
        
        movieDetailChildCoordinator.passParameter(value: viewModel)
        
        parentCoordinator?.childCoordinators.append(movieDetailChildCoordinator)
        movieDetailChildCoordinator.configureChildViewController()
    }
}
