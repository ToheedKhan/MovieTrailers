//
//  MovieDomainModel.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation

struct MovieDomainModel: Equatable {
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

struct MovieListDomainModel: Equatable {
    var movies: [MovieDomainModel]
}
