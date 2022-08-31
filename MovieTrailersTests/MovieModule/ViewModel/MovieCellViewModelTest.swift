//
//  MovieCellViewModelTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 29/07/22.
//

import XCTest
@testable import MovieTrailers

final class MovieListCellViewModelTest: XCTestCase {
    var movieListViewModel: IMovieListViewModel?
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
    
    func testMovieListCellViewModelInitializer() {
        guard let moviesList = movieUseCase.movies?.toPresentation(), let movie = moviesList.movies.first else {
            XCTFail("MovieDetailViewModelInitializer test failed - No movie found to initialize cell")
            return
        }
        let cellViewModel = MovieListCellViewModel.init(movie: movie)
        XCTAssertTrue(cellViewModel.title == movie.title)
        XCTAssertTrue(cellViewModel.overview == movie.overview)
        XCTAssertTrue(cellViewModel.popularity == String(describing: movie.popularity ?? 0))
        XCTAssertTrue(cellViewModel.voteCount == String(describing: movie.voteCount ?? 0))
        XCTAssertTrue(cellViewModel.rate == String(describing: movie.voteAverage ?? 0.0))
        XCTAssertTrue(cellViewModel.releaseDate == movie.releaseDate)
        XCTAssertTrue(cellViewModel.posterImagePath == movie.posterPath)
    }
    
    func testMovieCellViewModelInitializerWhenSomeMovieDetailsNotFound() {
        let movie = Movie.init(id: 1, popularity: nil, voteCount: nil, voteAverage: nil, title: nil, posterPath: "/test.png", originalLanguage: nil, originalTitle: nil, overview: nil, releaseDate: nil)
        let cellViewModel = MovieListCellViewModel.init(movie: movie)
        XCTAssertTrue(cellViewModel.title == "")
        XCTAssertTrue(cellViewModel.overview == "")
        XCTAssertTrue(cellViewModel.popularity == String(describing: movie.popularity ?? 0))
        XCTAssertTrue(cellViewModel.voteCount == String(describing: movie.voteCount ?? 0))
        XCTAssertTrue(cellViewModel.rate == String(describing: movie.voteAverage ?? 0.0))
        XCTAssertTrue(cellViewModel.releaseDate == "")
        XCTAssertTrue(cellViewModel.posterImagePath == movie.posterPath)
    }
}

