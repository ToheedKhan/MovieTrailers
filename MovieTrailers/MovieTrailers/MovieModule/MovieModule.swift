//
//  MovieModule.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation
import UIKit

class MovieModule {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func createMovieListViewController() -> UIViewController {
        let viewController = MovieListViewController.initialize(on: .main)
        viewController.viewModel = createMovieListViewModel()
        return viewController
    }
    
    private func createMovieListViewModel() -> MoviesListViewModelProtocol {
        let viewModel = MovieListViewModel(useCase: createMovieUseCase())
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
