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
    func didSelectItem(at index: Int)
}

protocol MoviesListViewModelOutput {
    var cellViewModels: Observable<[MovieListCellViewModel]> { get }
    var error: Observable<String> { get }

    var loading :((Bool) ->())! { get set }
    var isRefresh: ((Bool) -> ())! { get set }

    var screenTitle: String { get }
    var errorTitle: String { get }
}

protocol MoviesListViewModelProtocol: MoviesListViewModelInput, MoviesListViewModelOutput {}

final class MovieListViewModel: MoviesListViewModelProtocol {
 
    //MARK:- Variable & Constants:-
    private let useCase: FetchRecentMoviesUseCase
    private var movies: [MovieListCellViewModel] = []
    
    // MARK: - OUTPUT
    
    let cellViewModels: Observable<[MovieListCellViewModel]> = Observable([])

    let error: Observable<String> = Observable("")

    var loading: ((Bool) -> ())!
    var isRefresh: ((Bool) -> ())!
    
    var isSearching = false

    let screenTitle = NSLocalizedString("Movies", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    
    // MARK: - Init
    
    init(useCase: FetchRecentMoviesUseCase) {
        self.useCase = useCase
    }
    
    //MARK: - Private Methods
    //MARK:- NetWork
    
    private func fetchMovies() {
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
        cellViewModels.value = []//movies
    }
    
    private func handle(error: Error) {
        self.error.value = error.localizedDescription
    }

}
// MARK: - INPUT. View event methods

extension MovieListViewModel {
    
    func getMovies() {
        fetchMovies()
    }
    
    func didSearch(searchText: String) {
        isSearching = true
        
        cellViewModels.value = movies.filter { movie in
            if let movieTitle = movie.title {
                return movieTitle.lowercased().prefix(searchText.count) == searchText.lowercased()
            }
            return false
        }
    }
    func didCancelSearch() {
        isSearching =  false
        cellViewModels.value = movies
    }
    
    func didSelectItem(at index: Int) {
        isSearching = false
    }
}

