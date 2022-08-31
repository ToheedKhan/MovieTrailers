//
//  MovieDomainDTO+MappingExtension.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 31/08/22.
//

import Foundation

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
