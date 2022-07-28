//
//  MockRepository.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 15/07/22.
//

import Foundation
import PromiseKit
@testable import MovieTrailers


final class MockMovieRepository: MovieRepositoryProtocol {
    var movies: MovieList?
    var error: Error?

    func makeServiceCallToGetMovies() -> MovieResponse {
        return Promise { seal in
            if let error = error {
                seal.reject(error)
            } else {
                if let movie = movies {
                    seal.fulfill(movie)
                } else {
                    seal.reject(NSError(domain: "com.example.error", code: 1, userInfo: [NSLocalizedDescriptionKey: "No Data available"]))
                }
            }
        }
    }

}
