//
//  MockData.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 15/07/22.
//

import Foundation
@testable import MovieTrailers

class MockData {
    
    static var dataMovies: MovieListDataResponseDTO? {
        guard let mockMovieData = movieData else { return nil }
        return try! JSONDecoder().decode(MovieListDataResponseDTO.self, from: mockMovieData)
    }
    
    static var domainMovies: MovieListDomainModel? {
        guard let moviesData = dataMovies else { return nil }
        return moviesData.toDomain()
    }
    
    static var movieList: MovieList? {
        guard let moviesDomain = domainMovies else { return nil }
        
        return moviesDomain.toPresentation()
    }
    
    static var movieData: Data? {
        loadMovieResponseMockData("movie_data")
    }
    
    static func loadMovieResponseMockData(_ fromFile: String) -> Data? {
        guard let filePath = Bundle(for: self).path(forResource: fromFile, ofType: "json") else {
            debugPrint("movie_data.json file not found in bundle")
            return nil
        }
        let jsonString = try! String(contentsOfFile: filePath, encoding: .utf8)
        let data = jsonString.data(using: .utf8)!
        return data
    }
    
    static func mockMovieResponseData() -> Data {
        let encoded = try! JSONEncoder().encode(self.dataMovies)
        return encoded
    }
}
