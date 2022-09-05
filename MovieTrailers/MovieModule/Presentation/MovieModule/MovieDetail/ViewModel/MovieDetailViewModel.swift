//
//  MovieDetailViewModel.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 30/06/22.
//

import Foundation

struct MovieDetailViewModel {
    var posterImagePath: String?
    var overview: String
    var title: String
    
    init(movie: MovieListCellViewModel) {
        self.posterImagePath = movie.posterImagePath
        self.overview = movie.overview
        self.title = movie.title
    }
}
