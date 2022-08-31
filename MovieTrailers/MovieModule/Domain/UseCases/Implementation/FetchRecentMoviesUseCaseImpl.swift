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
    
    func fetchRecentMovies() -> Promise<MovieList> {
        return Promise {seal in
            repository.makeServiceCallToGetMovies().done(on: .main) { domainModelDTO in
                seal.fulfill(domainModelDTO.toPresentation())
            }
            .catch(on: .main, policy: .allErrors) { error in
                seal.reject(error)
            }
        }
    }
}
