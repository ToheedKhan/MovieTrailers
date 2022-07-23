//
//  MovieList.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation

struct MovieDTO: Codable {
    var movies: [Movie]
   
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
