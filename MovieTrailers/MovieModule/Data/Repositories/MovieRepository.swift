//
//  MovieRepository.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation
import PromiseKit

struct MovieRepository: MovieRepositoryProtocol {
    
    private let service: MovieServiceProtocol
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    func getMovies() -> MovieListDomainData {
        return Promise {seal in
            service.fetchMovieList().done(on: .main) { dataModelDTO in
                seal.fulfill(dataModelDTO.toDomain())
            }
            .catch(on: .main, policy: .allErrors) { error in
                seal.reject(error)
            }
        }
    }
}
