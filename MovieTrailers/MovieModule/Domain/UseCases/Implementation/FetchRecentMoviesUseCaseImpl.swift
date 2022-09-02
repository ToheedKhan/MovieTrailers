//
//  FetchRecentMoviesUseCaseImpl.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation
import PromiseKit

final class FetchRecentMoviesUseCaseImpl: FetchRecentMoviesUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchRecentMovies() ->MovieListDomainData {
        return repository.fetchMovies()
    }
}
