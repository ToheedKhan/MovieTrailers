//
//  MockData.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 15/07/22.
//

import Foundation
@testable import MovieTrailers


class StubGenerator {
    func stubMovies() -> MovieList? {
        let testBundle = Bundle(for: type(of: self))
        
        guard let filePath = testBundle.path(forResource: "movie_data", ofType: "json") else {
            debugPrint("movie_data.json file not found in bundle")
            return nil
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        var movieList: MovieList?
        do {
            movieList = try decoder.decode(MovieList.self, from: data)
            debugPrint(movieList?.movies ?? [])
        } catch let error {
            debugPrint("error occured while decoding = \(error.localizedDescription)")
        }
        return movieList
    }
}


struct MockData {
    static func mockMovieResponseData() -> Data {
        let encoded = try! JSONEncoder().encode(StubGenerator().stubMovies())
        return encoded
    }
}
