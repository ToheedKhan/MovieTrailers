//
//  MovieDataResponseDTO.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 30/08/22.
//

import Foundation

struct MovieListDataResponseDTO: Codable {
    var movies: [MovieDataResponseDTO]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct MovieDataResponseDTO: Codable {
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case popularity
        case title
        case overview
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case releaseDate = "release_date"
    }
}

// Mapping Data to Domain

extension MovieListDataResponseDTO {
    
    func toDomain() -> MovieListDomainModel {
        return .init(movies: movies.map({$0.toDomain()}))
    }
}

extension MovieDataResponseDTO {
    func toDomain() -> MovieDomainModel {
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
