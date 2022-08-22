//
//  FetchRecentMoviesUseCase.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation
//typealias MovieResponse = Promise<MovieList>

protocol FetchRecentMoviesUseCase {
    func fetchRecentMovies() -> MovieResponse //Remove, Change name
}
