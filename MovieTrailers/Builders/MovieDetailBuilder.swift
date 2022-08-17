//
//  MovieDetailBuilder.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 16/08/22.
//

import Foundation

struct MovieDetailBuilder {
    func buildMovieDetailViewController() -> MovieDetailViewController {
        let movieDetailVC = MovieDetailViewController.initialize(on: .main)
        return movieDetailVC
    }
    
    //MARK: - Private Methods
     func createMovieDetailViewModel(with movieCellViewModel: MovieListCellViewModel) -> MovieDetailViewModel {
        let viewModel = MovieDetailViewModel(movie: movieCellViewModel)
        return viewModel
    }
}
