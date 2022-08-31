//
//  FetchRecentMoviesUseCase.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation
import PromiseKit

protocol FetchRecentMoviesUseCase {
    func fetchRecentMovies() -> Promise<MovieList>
}
