//
//  MovieListViewModelTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 15/07/22.
//

import XCTest
@testable import MovieTrailers

final class MovieListViewModelTest: XCTestCase {
    
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
        var isMovieTitleContainsSearchedText: Bool =  false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [self] in
            movieListViewModel?.didSearch(searchText: searchText)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [self] in
                
                if let movieTitle = movieListViewModel?.cellViewModels.first?.title {
                    isMovieTitleContainsSearchedText =  movieTitle.lowercased().contains(searchText.lowercased())
                }
                searchExpectation.fulfill()
            })
        })
        wait(for: [searchExpectation], timeout: 10)
        
        XCTAssertTrue(isMovieTitleContainsSearchedText, "Movie Found")
    }
    
    func testSearchMovieNotFoundCase() {
        let searchExpectation = XCTestExpectation(description: "searchExpectation")
        
        let searchText = "Topp"
        movieUseCase.movies = StubGenerator().stubMovies()
        movieListViewModel?.getMovies()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [self] in
            movieListViewModel?.didSearch(searchText: searchText)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [self] in
                
                XCTAssertTrue(movieListViewModel?.cellViewModels.count == 0, "Searched Movie Not Found")
                
                searchExpectation.fulfill()
            })
        })
        wait(for: [searchExpectation], timeout: 10)
    }
    
    func testWhenUserCancelCellViewModelCountShouldBeEqualToTotalMovieCount() {
        movieUseCase.movies = StubGenerator().stubMovies()
        movieListViewModel?.getMovies()
        let cancelSearchExpectation = XCTestExpectation(description: "searchExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [self] in
            movieListViewModel?.didSearch(searchText: "Sonic")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [self] in
                movieListViewModel?.didCancelSearch()
                cancelSearchExpectation.fulfill()
            })
        })
        
        wait(for: [cancelSearchExpectation], timeout: 5)
        XCTAssertEqual(movieUseCase.movies?.movies.count, movieListViewModel?.cellViewModels.count)
    }
}
