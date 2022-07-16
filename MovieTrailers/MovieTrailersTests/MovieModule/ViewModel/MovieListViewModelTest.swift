//
//  MovieListViewModelTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 15/07/22.
//

import XCTest
@testable import MovieTrailers

class MovieListViewModelTest: XCTestCase {
    
    var movieListViewModel: MovieListViewModel?
    var movieUseCase = MockFetchMovieUseCase()
    private var promise: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        movieListViewModel = MovieListViewModel(useCase: movieUseCase)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
//    func testViewModel_Success() {
//        promise = expectation(description: "Should get success")
//        movieUseCase.movies = StubGenerator().stubMovies()
//        movieListViewModel?.getMovies()
//        wait(for: [promise], timeout: 10.0)
//    }
//    
//    func testViewModel_Fail() {
//        promise = expectation(description: "Should get fail")
//        movieUseCase.error = NSError(domain: "com.example.error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed Error"])
//        movieListViewModel?.getMovies()
//        wait(for: [promise], timeout: 10.0)
//    }
}
