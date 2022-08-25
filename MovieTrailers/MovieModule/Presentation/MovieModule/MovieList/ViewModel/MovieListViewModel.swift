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
    
    init(useCase: FetchRecentMoviesUseCase) {
        self.useCase = useCase
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
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            isSearching = true
            cellViewModels = (movies.filter {  $0.title.lowercased().contains(searchText.lowercased())})
            successResponse?()
        }
    }
    
    func didCancelSearch() {
        guard isSearching else { return }
        isSearching =  false
        cellViewModels = movies
        self.successResponse?()
    }
}
