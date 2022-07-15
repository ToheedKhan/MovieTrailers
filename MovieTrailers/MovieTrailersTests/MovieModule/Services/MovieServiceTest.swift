//
//  MovieServiceTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 15/07/22.
//

import XCTest
@testable import MovieTrailers

class MovieServiceTest: XCTestCase {
    
    struct ErrorMessage {
        static let kFailedErrorMessage = "Movie fetching failed error"
    }
    
    var movieService: MovieService!
    let mockNetworkManager = MockNetworkManager()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        movieService = MovieService(network: mockNetworkManager)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testService_Success() {
        let promise = expectation(description: "Movie service on success case")
        mockNetworkManager.movies = StubGenerator().stubMovies()
        movieService.fetchMovieList()
            .done { model in
                let moviesCount = model.movies.count
                if moviesCount >= 1 {
                    promise.fulfill()
                }
            }
            .catch { _ in
                promise.fulfill()
            }
        wait(for: [promise], timeout: 2.0)
    }
    
    
    func testService_Error() {
        let promise = expectation(description: "Movie service on success case")
        mockNetworkManager.error = NSError(domain: "com.example.error", code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.kFailedErrorMessage])
        movieService.fetchMovieList()
            .catch { _ in
                promise.fulfill()
            }
        wait(for: [promise], timeout: 2.0)
    }
    
}
