//
//  MovieRepository.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation

struct MovieRepository: MovieRepositoryProtocol {
    
    private let service: MovieServiceProtocol
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    func makeServiceCallToGetMovies() -> MovieResponse {
        return service.fetchMovieList()
    }
    
}


