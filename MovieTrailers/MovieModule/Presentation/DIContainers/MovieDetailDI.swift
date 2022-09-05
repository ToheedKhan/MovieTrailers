//
//  MovieDetailDI.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 16/08/22.
//

import Foundation

struct MovieDetailDI {
    func createMovieDetailViewController(selectedMovieCellViewModel: MovieListCellViewModel) -> MovieDetailViewController {
        let viewModel = createMovieDetailViewModel(with: selectedMovieCellViewModel)
        let movieDetailVC = MovieDetailViewController.initialize(on: .main)
        movieDetailVC.viewModel = viewModel
        return movieDetailVC
    }
    
    //MARK: - Private Methods
    private func createMovieDetailViewModel(with movieCellViewModel: MovieListCellViewModel) -> MovieDetailViewModel {
        let viewModel = MovieDetailViewModel(movie: movieCellViewModel)
        return viewModel
    }
}
