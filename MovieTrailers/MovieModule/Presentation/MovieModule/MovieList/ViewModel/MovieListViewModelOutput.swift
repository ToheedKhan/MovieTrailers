//
//  MovieListViewModelOutput.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 31/08/22.
//

import Foundation

protocol MovieListViewModelOutput {
    func handleSuccess()
    func handleError(_ error: String)
}
