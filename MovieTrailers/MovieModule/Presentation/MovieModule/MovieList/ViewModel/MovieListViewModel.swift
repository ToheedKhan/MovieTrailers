//
//  MovieListViewModel.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation

struct MovieListViewModelActions {
    let showMovieDetails: (MovieListCellViewModel) -> Void
}

protocol MoviesListViewModelInput {
    func getMovies()
    func didSearch(searchText: String)
    func didCancelSearch()
    func didSelectMovieAt(index: Int)
}

protocol MoviesListViewModelOutput {
    var successResponse: (() -> Void)? { get set }
    var errorResponse: ((String) -> Void)? { get set }
    
    var loading :((Bool) ->()) { get set }
    var isRefresh: ((Bool) -> ()) { get set }
    var isSearching: Bool { get }

    var screenTitle: String { get }
    var errorTitle: String { get }
    
    var cellViewModels: [MovieListCellViewModel] {get}
}
//Protocol Composition
//Method 1
//protocol MoviesListViewModelProtocol: MoviesListViewModelInput, MoviesListViewModelOutput {}
//Method 2
 typealias MoviesListViewModelProtocol = MoviesListViewModelInput & MoviesListViewModelOutput

final class MovieListViewModel: MoviesListViewModelProtocol {
    
    //MARK:- Variable & Constants:-
    private let useCase: FetchRecentMoviesUseCase
    private let actions: MovieListViewModelActions?
    private var movies: [MovieListCellViewModel] = []
    
    var cellViewModels: [MovieListCellViewModel] = []
    
    // MARK: - OUTPUT
    
    var successResponse: (() -> Void)?
    var errorResponse: ((String) -> Void)?
    
    var loading :((Bool) ->()) = {_ in}
    var isRefresh :((Bool) ->()) = {_ in}
    var isSearching = false
    
    let screenTitle = "Movies"
    let errorTitle = "Error"
    
    // MARK: - Init
    
    init(useCase: FetchRecentMoviesUseCase, actions: MovieListViewModelActions? = nil) {
        self.useCase = useCase
        self.actions = actions
    }
    
    //MARK: - Private Methods
    //MARK:- NetWork
    
    func fetchMovies() {
        self.loading(true)
        useCase.fetchRecentMovies()
            .done(on: .main) { [weak self] model in
                debugPrint("Success ===> ", model)
                self?.getData(model: model)
            }
            .catch(on: .main, policy: .allErrors) { [weak self] error in
                self?.handle(error: error)
            }
            .finally {
                self.loading(false)
                self.isRefresh(false)
            }
    }
    
    private func getData(model: MovieList) {
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
        self.fetchMovies()
    }
    
    func didSearch(searchText: String) {
        isSearching = true
        
        cellViewModels = movies.filter { movie in
            if let movieTitle = movie.title {
                return movieTitle.lowercased().contains(searchText.lowercased())
                
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
    
    func didSelectMovieAt(index: Int) {
        actions?.showMovieDetails(cellViewModels[index])
    }
}
