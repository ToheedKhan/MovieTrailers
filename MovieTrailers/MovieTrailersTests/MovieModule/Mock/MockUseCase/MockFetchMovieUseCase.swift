//
//  MockFetchRecentMovieUseCase.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 15/07/22.
//

import Foundation

import PromiseKit
@testable import MovieTrailers

class MockFetchMovieUseCase : FetchRecentMoviesUseCase {
    
    var movies: MovieDTO?
    var error: Error?
    
    func fetchRecentMovies() -> MovieResponse {
        return Promise { seal in
            if let error = error {
                seal.reject(error)
            } else {
                if let fetchedMovies = movies {
                    seal.fulfill(fetchedMovies)
                }
            }
        }
    }
    
}
