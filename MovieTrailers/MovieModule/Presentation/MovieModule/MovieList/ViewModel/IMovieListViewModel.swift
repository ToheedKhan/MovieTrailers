//
//  IMovieListViewModel.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation

protocol IMovieListViewModel {
    var loading :((Bool) ->()) { get set }
    var isRefresh: ((Bool) -> ()) { get set }
    var isSearching: Bool { get }
    
    var screenTitle: String { get }
    var errorTitle: String { get }
    
    var movieCellViewModels: [MovieListCellViewModel] {get}
    
    func fetchMovies()
    func didSearch(searchText: String)
    func didCancelSearch()
    
    var outputDelegate: MovieListViewModelOutput? { get set }
}
