//
//  MovieListViewModelImpl.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 31/08/22.
//

import Foundation

final class MovieListViewModelImpl: IMovieListViewModel {
    
    //MARK:- Variable & Constants:-
    private let useCase: FetchRecentMoviesUseCase
    private var movies: [MovieListCellViewModel] = []

    var isSearching = false
    
    let screenTitle = "Movies"
    let errorTitle = "Error"
    
    var movieCellViewModels: [MovieListCellViewModel] = []
    
    weak var outputDelegate: MovieListViewModelOutput?
    
    // MARK: - Init
    
    init(useCase: FetchRecentMoviesUseCase,
         outputDelegate: MovieListViewModelOutput?) {
        self.useCase = useCase
        self.outputDelegate = outputDelegate
    }
    
    //MARK: - Private Methods
    //MARK:- NetWork
    
    func fetchMovies() {
        useCase.fetchRecentMovies()
            .done(on: .main) { [weak self] domainModelDTO in
                debugPrint("Success ===> ", domainModelDTO)
                let model = domainModelDTO.toPresentation()
                self?.getData(model: model)
            }
            .catch(on: .main, policy: .allErrors) { [weak self] error in
                self?.outputDelegate?.handleError(error.localizedDescription)
            }
            .finally {
            }
    }
    
    private func getData(model: MovieList) {
        movies = model.movies.map(MovieListCellViewModel.init)
        movieCellViewModels = movies
        outputDelegate?.handleSuccess()
    }
        
    // MARK: - INPUT. View event methods
    
    func getMovies() {
        self.fetchMovies()
    }
    
    func didSearch(searchText: String) {
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            isSearching = true
            movieCellViewModels = (movies.filter {  $0.title.lowercased().contains(searchText.lowercased())})
            outputDelegate?.handleSuccess()
        }
    }
    
    func didCancelSearch() {
        guard isSearching else { return }
        isSearching =  false
        movieCellViewModels = movies
        outputDelegate?.handleSuccess()
    }
}
