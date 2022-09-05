//
//  MovieDetailViewControllerTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 16/07/22.
//

@testable import MovieTrailers
import XCTest

final class MovieDetailViewControllerTests: XCTestCase {
    
    var viewControllerUnderTest: MovieDetailViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        viewControllerUnderTest = storyboard.instantiateViewController(identifier: "\(MovieDetailViewController.self)")
        
        self.mockModelData()
        viewControllerUnderTest.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewControllerUnderTest = nil
        super.tearDown()
    }
    
    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(viewControllerUnderTest.overviewLabel, "overviewTextView")
        XCTAssertNotNil(viewControllerUnderTest.posterImageView, "posterImageView")
    }
}

//MARK: - Private Helper
extension MovieDetailViewControllerTests {
    private func mockModelData() {
        let movieUseCase = MockFetchMovieUseCase()
        movieUseCase.movies = MockData.domainMovies
        
        guard let movie = movieUseCase.movies?.toPresentation().movies.first else {
            XCTFail("MovieDetailViewModelInitializer test failed - No movie found to initialize cell")
            return
        }
        viewControllerUnderTest.viewModel = MovieDetailViewModel.init(movie: MovieListCellViewModel.init(movie: movie))
    }
}
