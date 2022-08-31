//
//  Movie.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 30/08/22.
//

import Foundation

struct Movie: Equatable {
    var id: Int
    var popularity: Float?
    var voteCount: Int?
    var voteAverage: Float?
    var title: String?
    var posterPath: String?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var releaseDate: String?
}

struct MovieList: Equatable {
    var movies: [Movie]
}
