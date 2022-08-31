//
//  MockNetworkManager.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 15/07/22.
//

import Foundation
import PromiseKit
@testable import MovieTrailers

final class MockNetworkManager: NetworkManagerProtocol {
    
    var movies: MovieListDataResponseDTO?
    var error: Error?
    
    func request<T: Decodable>(_ type: T.Type, endPoint: INetworkRequest) -> Response<T> {
        return Promise { seal in
            if let error = error {
                seal.reject(error)
            } else {
                if let movie = movies {
                    seal.fulfill(movie as! T)
                } else {
                    seal.reject(NSError(domain: "com.example.error", code: 1, userInfo: [NSLocalizedDescriptionKey: "No Data available"]))
                }
            }
        }
    }
    
}
