//
//  MovieService.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation

struct MovieService: MovieServiceProtocol {
    
    private let network: NetworkManagerProtocol
    
    init(network: NetworkManagerProtocol) {
        self.network = network
    }
    
    //MARK: - MovieServiceProtocol
    func fetchMovieList() -> MovieDataResponse {
        let endPoint = NetworkRequest(path: MovieAPIConstants.moviesAPIPath, method: .get, queryParameters:queryParameterToGetMovies())
        let promise = network.request(MovieListDataResponseDTO.self, endPoint: endPoint)
        return promise
    }
    
    //MARK: - Private Methods
    private func queryParameterToGetMovies() ->  [String : Any] {
        return ["sort_by" : "popularity.desc", "api_key" : ApplicationConfiguration.apiKey]
    }
}
