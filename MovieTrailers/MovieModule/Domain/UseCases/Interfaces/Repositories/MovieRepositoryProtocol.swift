//
//  MovieRepositoryProtocol.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation
import PromiseKit

typealias MovieListDomainData = Promise<MovieListDomainDTO>

protocol MovieRepositoryProtocol {
    func makeServiceCallToGetMovies() -> MovieListDomainData
}
