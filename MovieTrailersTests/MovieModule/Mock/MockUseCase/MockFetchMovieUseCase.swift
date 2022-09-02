//
//  MockFetchRecentMovieUseCase.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 15/07/22.
//

import Foundation
import PromiseKit

@testable import MovieTrailers

final class MockFetchMovieUseCase : FetchRecentMoviesUseCase {
    
    var movies: MovieListDomainModel?
    var error: Error?
    
    func fetchRecentMovies() -> MovieListDomainData {
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
