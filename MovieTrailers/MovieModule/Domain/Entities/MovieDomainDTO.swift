//
//  Movie.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation

struct MovieDomainDTO: Equatable {
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

struct MovieListDomainDTO: Equatable {
    var movies: [MovieDomainDTO]
}

// Mapping Data to Presentation
extension MovieListDomainDTO {
    
    func toPresentation() -> MovieList {
        return .init(movies: movies.map({$0.toPresentation()}))
    }
}

extension MovieDomainDTO {
    func toPresentation() -> Movie {
        return .init(id: self.id,
                     popularity: self.popularity,
                     voteCount: self.voteCount,
                     voteAverage: self.voteAverage,
                     title: self.title,
                     posterPath: self.posterPath,
                     originalLanguage: self.posterPath,
                     originalTitle: self.originalTitle,
                     overview: self.overview,
                     releaseDate: self.releaseDate)
    }
}
