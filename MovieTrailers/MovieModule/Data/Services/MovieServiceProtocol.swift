//
//  MovieServiceProtocol.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovieList() -> MovieResponse
}