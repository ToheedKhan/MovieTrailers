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
    
    override func setUp() {
        super.setUp()
        movieListViewModel = MovieListViewModel(useCase: movieUseCase)
    }
    
    override func tearDown() {
        movieListViewModel = nil
        super.tearDown()
    }
    
    func testViewModel_Success() {
        let promise = expectation(description: "Should get success")
        movieUseCase.movies = StubGenerator().stubMovies()
        movieListViewModel?.getMovies()
        movieListViewModel?.successResponse = {
            promise.fulfill()
        }
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectations testViewModelSuccess case Failed - errored: \(error)")
            }
        }
    }
    
    func testViewModel_Fail() {
        let promise = expectation(description: "Should get fail")
        movieUseCase.error = NSError(domain: "com.example.error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])
        movieListViewModel?.getMovies()
        
        movieListViewModel?.errorResponse = { error in
            XCTAssertTrue(error == "Something went wrong")
            
            promise.fulfill()
        }
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectations testViewModelFail case Failed - errored: \(error)")
            }
        }
    }
    
    func testSearchMovie() {
        let searchExpectation = XCTestExpectation(description: "searchExpectation")
        
        let searchText = "Sonic"
        movieUseCase.movies = StubGenerator().stubMovies()
        movieListViewModel?.getMovies()
        var isMovieHasPrefix: Bool =  false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [self] in
            movieListViewModel?.didSearch(searchText: searchText)
            
            if let movieTitle = self.movieListViewModel?.cellViewModels.first?.title {
                isMovieHasPrefix =  movieTitle.hasPrefix(searchText)
                
            }
            searchExpectation.fulfill()
        })
        wait(for: [searchExpectation], timeout: 5)
        
        XCTAssertTrue(isMovieHasPrefix, "Movie Found")
    }
    
    func testWhenUserCancelCellViewModelCountShouldBeEqualToTotalMovieCount() {
        movieUseCase.movies = StubGenerator().stubMovies()
        movieListViewModel?.getMovies()
        let cancelSearchExpectation = XCTestExpectation(description: "searchExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [self] in
            movieListViewModel?.didSearch(searchText: "Sonic")
            movieListViewModel?.didCancelSearch()
            cancelSearchExpectation.fulfill()
        })
        
        wait(for: [cancelSearchExpectation], timeout: 5)
        XCTAssertEqual(movieUseCase.movies?.movies.count, movieListViewModel?.cellViewModels.count)
    }
}
