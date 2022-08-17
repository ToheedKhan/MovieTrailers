//
//  MovieListChildCoordinatorTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 17/08/22.
//

@testable import MovieTrailers
import XCTest

final class MovieListChildCoordinatorTest: XCTestCase {
    
    private var sut: MovieListChildCoordinator!
    private var navigationController: UINavigationController!
    private var parentCoordinator: MainCoordinator!
    
    override func setUp() {
        super.setUp()
        
        navigationController
        = UINavigationController()
        
         parentCoordinator = MainCoordinator.init(with: navigationController)
        sut = MovieListChildCoordinator.init(with: parentCoordinator.navigationController)
        sut.parentCoordinator = parentCoordinator
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
