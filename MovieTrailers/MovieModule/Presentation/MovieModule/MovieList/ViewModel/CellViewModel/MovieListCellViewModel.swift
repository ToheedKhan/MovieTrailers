//
//  MovieCellViewModel.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation

struct MovieListCellViewModel {
    
    //MARK:- Variable:-
    let posterImagePath: String?
    let title: String
    let releaseDate: String
    let rate: String
    let voteCount: String
    let popularity: String
    let overview: String
}

extension MovieListCellViewModel {
    
    init(movie: Movie) {
        self.posterImagePath = movie.posterPath
        self.title = movie.title ?? ""
        self.rate = String(describing: movie.voteAverage ?? 0.0)
        self.voteCount = String(describing: movie.voteCount ?? 0)
        self.popularity = String(describing: movie.popularity ?? 0)
        self.overview = movie.overview ?? ""
        self.releaseDate = movie.releaseDate ?? ""
    }
}
