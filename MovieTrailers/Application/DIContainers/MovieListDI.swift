//
//  MovieListDI.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 16/08/22.
//

import UIKit

struct MovieListDI {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func createMovieListViewController()-> MovieListViewController {
        let viewController = MovieListViewController.initialize(on: .main)
        viewController.viewModel = createMovieListViewModel(outputDelegate: viewController)
        return viewController
    }
    
    //MARK: - Private Methods
    
    private func createMovieListViewModel(outputDelegate: MovieListViewModelOutput?) -> IMovieListViewModel {
        let viewModel = MovieListViewModelImpl(useCase: createMovieUseCase(),
                                               outputDelegate: outputDelegate)
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
