//
//  Movie.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation

struct Movie: Codable, Identifiable, Equatable {
    var id: Int
    var popularity: Float?
    var voteCount: Int?
    var voteAverage: Float?
    var title: String?
    var posterPath: String?
    var originalLanguage: String?
    var originalTitle: String?
    var adult: Bool
    var overview: String?
    var releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case popularity
        case title
        case adult
        case overview
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case releaseDate = "release_date"
    }
}
