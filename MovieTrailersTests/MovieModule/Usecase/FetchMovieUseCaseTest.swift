//
//  FetchMovieUseCaseTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 15/07/22.
//

import XCTest
@testable import MovieTrailers


class FetchMovieUseCaseTest: XCTestCase {
    
    struct ErrorMessage {
        static let kFailedErrorMessage = "Use Case Failed Error"
    }
    
    var fetchMovieUseCase: FetchRecentMoviesUseCaseImpl!
    let repository = MockMovieRepository()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fetchMovieUseCase = FetchRecentMoviesUseCaseImpl(repository: repository)
    }
    
    override func tearDown() {
        fetchMovieUseCase = nil
        super.tearDown()
    }
    
    func testUseCase_Success() {
        let promise = expectation(description: "Movie use case on success")
        
        repository.movies = StubGenerator().stubMovies()
        
        fetchMovieUseCase.fetchRecentMovies()
            .done { model in
                let movieCount = model.movies.count
                if movieCount >= 1 {
                    promise.fulfill()
                }
            }
            .catch { _ in
                XCTFail("testUseCase_Success case Failed - movie count is not > 1 after making service call to fetchRecentMovies() from FetchRecentMoviesUseCaseImpl")
                promise.fulfill()
            }
        
        wait(for: [promise], timeout: 2.0)
    }
    
    func testUseCase_Failure() {
        let promise = expectation(description: "Movie use case on failed")
        repository.error = NSError(domain: "com.example.error", code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.kFailedErrorMessage])
        
        fetchMovieUseCase.fetchRecentMovies()
            .catch { error in
                XCTAssertTrue(error.localizedDescription == ErrorMessage.kFailedErrorMessage)
                promise.fulfill()
            }
        
        wait(for: [promise], timeout: 2.0)
    }
    
}
