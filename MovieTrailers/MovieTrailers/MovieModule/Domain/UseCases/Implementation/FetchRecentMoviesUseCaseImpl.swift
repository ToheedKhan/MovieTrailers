//
//  FetchRecentMoviesUseCaseImpl.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation

class FetchRecentMoviesUseCaseImpl: FetchRecentMoviesUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchRecentMovies() -> MovieResponse {
        return repository.makeServiceCallToGetMovies()
    }
}
