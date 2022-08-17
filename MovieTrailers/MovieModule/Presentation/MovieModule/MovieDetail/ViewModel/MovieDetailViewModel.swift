//
//  MovieDetailViewModel.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 30/06/22.
//

import Foundation

struct MovieDetailViewModel: Decodable {
    var posterImagePath: String?
    var overview: String
    var movieTitle: String
    
    init(movie: MovieListCellViewModel) {
        self.posterImagePath = movie.posterImagePath
        self.overview = movie.overview
        self.movieTitle = movie.title
    }
}
