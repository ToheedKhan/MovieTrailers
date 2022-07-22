//
//  MovieModule.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation
import UIKit

struct MovieModule {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func createMovieFlowCoordinator(navigationController: UINavigationController) -> MovieFlowCoordinator {
        return MovieFlowCoordinator.init(navigationController: navigationController, movieModule: self)
    }
    
    func createMovieListViewController(actions: MovieListViewModelActions) -> UIViewController {
        let viewController = MovieListViewController.initialize(on: .main)
        viewController.viewModel = createMovieListViewModel(actions: actions)
        return viewController
    }
    
    func createMovieDetailViewController(with movieCellViewModel: MovieListCellViewModel) -> MovieDetailViewController {
        let movieDetailVC = MovieDetailViewController.initialize(on: .main)
        movieDetailVC.viewModel = createMovieDetailViewModel(with: movieCellViewModel)
        return movieDetailVC
    }
    
    //MARK: - Private Methods
    private func createMovieDetailViewModel(with movieCellViewModel: MovieListCellViewModel) -> MovieDetailViewModel {
        let viewModel = MovieDetailViewModel(movie: movieCellViewModel)
        return viewModel
    }
    
    private func createMovieListViewModel(actions: MovieListViewModelActions) -> MoviesListViewModelProtocol {
        let viewModel = MovieListViewModel(useCase: createMovieUseCase(), actions: actions)
        return viewModel
    }
    
    private func createMovieUseCase() -> FetchRecentMoviesUseCase {
        let useCase = FetchRecentMoviesUseCaseImpl(repository: createMovieRepository())
        return useCase
    }
    
    private func createMovieRepository() -> MovieRepositoryProtocol {
        let repository = MovieRepository(service: createMovieService())
        return repository
    }
    
    private func createMovieService() -> MovieServiceProtocol {
        let service = MovieService(network: networkManager)
        return service
    }
    
}
