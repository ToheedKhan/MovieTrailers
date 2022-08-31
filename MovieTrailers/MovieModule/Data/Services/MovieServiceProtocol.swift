//
//  MovieServiceProtocol.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation
import PromiseKit

typealias MovieDataResponse = Promise<MovieListDataResponseDTO>

protocol MovieServiceProtocol {
    func fetchMovieList() -> MovieDataResponse
}
