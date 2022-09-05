//
//  MovieListDetailViewModelTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 29/07/22.
//

import XCTest
@testable import MovieTrailers


final class MovieListDetailViewModelTest: XCTestCase {
    var movieListViewModel: MovieListViewModelImpl?
    var movieUseCase = MockFetchMovieUseCase()
    
    override func setUp() {
        super.setUp()
        movieListViewModel = MovieListViewModelImpl(useCase: movieUseCase, outputDelegate: nil)
        movieUseCase.movies = MockData.domainMovies
    }
    
    override func tearDown() {
        movieUseCase.movies = nil
        movieListViewModel = nil
        super.tearDown()
    }
    
    func testMovieDetailViewModelInitializer() {
        guard let movie = movieUseCase.movies?.toPresentation().movies.first else {
            XCTFail("MovieDetailViewModelInitializer test failed - No movie found to initialize cell")
            return
        }
        let movieListCellVM = MovieListCellViewModel.init(movie: movie)
        let movieDetailVM = MovieDetailViewModel.init(movie: movieListCellVM)
        XCTAssertTrue(movieDetailVM.title == movieListCellVM.title)
        XCTAssertTrue(movieDetailVM.overview == movieListCellVM.overview)
        XCTAssertTrue(movieDetailVM.posterImagePath == movieListCellVM.posterImagePath)
    }
}
