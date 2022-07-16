//
//  MovieListViewModel.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation

protocol MoviesListViewModelInput {
    func getMovies()
    func didSearch(searchText: String)
    func didCancelSearch()
}

protocol MoviesListViewModelOutput {
    var successResponse: (() -> Void)? { get set }
    var errorResponse: ((String) -> Void)? { get set }
    
    var loading :((Bool) ->())! { get set }
    var isRefresh: ((Bool) -> ())! { get set }

    var screenTitle: String { get }
    var errorTitle: String { get }
    
    var cellViewModels: [MovieListCellViewModel] {get}

}

protocol MoviesListViewModelProtocol: MoviesListViewModelInput, MoviesListViewModelOutput {}

final class MovieListViewModel: MoviesListViewModelProtocol {
 
    //MARK:- Variable & Constants:-
    private let useCase: FetchRecentMoviesUseCase
    private var movies: [MovieListCellViewModel] = []
    var cellViewModels: [MovieListCellViewModel] = []
    var isSearching = false

    // MARK: - OUTPUT

    var successResponse: (() -> Void)?
    var errorResponse: ((String) -> Void)?
    
    var loading: ((Bool) -> ())!
    var isRefresh: ((Bool) -> ())!

    let screenTitle = NSLocalizedString("Movies", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    
    // MARK: - Init
    
    init(useCase: FetchRecentMoviesUseCase) {
        self.useCase = useCase
    }
    
    //MARK: - Private Methods
    //MARK:- NetWork
    
     func fetchMovies() {
        self.loading?(true)
        useCase.fetchRecentMovies()
            .done(on: .main) { [weak self] model in
                debugPrint("Success ===> ", model)
                self?.getData(model: model)
            }
            .catch(on: .main, policy: .allErrors) { [weak self] error in
                self?.handle(error: error)
            }
            .finally {
                self.loading?(false)
                self.isRefresh?(false)
            }
    }
    
    private func getData(model: MovieDTO) {
        movies = model.movies.map(MovieListCellViewModel.init)
        cellViewModels = movies
        self.successResponse?()
    }
    
    private func handle(error: Error) {
        self.errorResponse?(error.localizedDescription )
    }

}
// MARK: - INPUT. View event methods

extension MovieListViewModel {
    
    func getMovies() {
        fetchMovies()
    }
    
    func didSearch(searchText: String) {
        isSearching = true
        
        cellViewModels = movies.filter { movie in
            if let movieTitle = movie.title {
                return movieTitle.lowercased().prefix(searchText.count) == searchText.lowercased()
            }
            return false
        }
        self.successResponse?()
    }
    func didCancelSearch() {
        isSearching =  false
        cellViewModels = movies
        self.successResponse?()
    }
}

