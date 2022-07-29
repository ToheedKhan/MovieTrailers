//
//  MovieListDetailViewModelTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 29/07/22.
//

import XCTest
@testable import MovieTrailers


final class MovieListDetailViewModelTest: XCTestCase {
    var movieListViewModel: MovieListViewModel?
    var movieUseCase = MockFetchMovieUseCase()
    
    override func setUp() {
        super.setUp()
        movieListViewModel = MovieListViewModel(useCase: movieUseCase)
        movieUseCase.movies = StubGenerator().stubMovies()
    }
    
    override func tearDown() {
        movieListViewModel = nil
        super.tearDown()
    }
    
    func testMovieDetailViewModelInitializer() {
        guard let movie = movieUseCase.movies?.movies.first else {
            XCTFail("MovieDetailViewModelInitializer test failed - No movie found to initialize cell")
            return
        }
        let movieListCellVM = MovieListCellViewModel.init(movie: movie)
        let movieDetailVM = MovieDetailViewModel.init(movie: movieListCellVM)
        XCTAssertTrue(movieDetailVM.movieTitle == movieListCellVM.title)
        XCTAssertTrue(movieDetailVM.overview == movieListCellVM.overview)
        XCTAssertTrue(movieDetailVM.posterImagePath == movieListCellVM.posterImagePath)
    }
}
