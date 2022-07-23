//
//  MockData.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 15/07/22.
//

import Foundation
@testable import MovieTrailers


class StubGenerator {
    func stubMovies() -> MovieDTO {
        let testBundle = Bundle(for: type(of: self))
        
        let filePath = testBundle.path(forResource: "movie_data", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let movieList = try! decoder.decode(MovieDTO.self, from: data)
        return movieList
    }
}


struct MockData {
    static func mockMovieResponseData() -> Data {
        let encoded = try! JSONEncoder().encode(StubGenerator().stubMovies())
        return encoded
    }
}
