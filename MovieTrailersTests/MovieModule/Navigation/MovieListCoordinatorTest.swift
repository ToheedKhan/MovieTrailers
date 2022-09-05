//
//  MovieListCoordinatorTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 05/09/22.
//

@testable import MovieTrailers
import XCTest

final class MovieListCoordinatorTestTest: XCTestCase {
    
    private var sut: MovieListCoordinator!
    private var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        
        navigationController
        = UINavigationController()
        
        sut = MovieListCoordinator.init(navigationController: navigationController)
    }
    
    override func tearDown() {
        sut = nil
        navigationController = nil
        
        super.tearDown()
    }
    
    func test_whenConfigureChildViewControllerCalled_thenMovieDetailVCAddedToNavigationStack() {
        
        let movie = Movie(id: 1, popularity: 0.4, voteCount: 400, voteAverage: 50, title: "Prey", posterPath: nil, originalLanguage: nil, originalTitle: nil, overview: nil, releaseDate: "22/4/2020")
        let cellVM = MovieListCellViewModel(movie: movie)
        
        sut.navigateToMovieDetailVC(viewModel: cellVM)
        
        XCTAssertTrue(navigationController.children.last is MovieDetailViewController)
        
    }
}
