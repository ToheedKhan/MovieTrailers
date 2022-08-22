//
//  MovieListViewControllerTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 16/07/22.
//

@testable import MovieTrailers
import XCTest

final class MovieListViewControllerTests: XCTestCase {
    
    var viewControllerUnderTest : MovieListViewController!
    var movieListViewModel: MovieListViewModel?
    var movieUseCase = MockFetchMovieUseCase()
    private var parentCoordinator: MainCoordinator!
    private var navigationController: UINavigationController!
    private var movieListChildCoordinator: MovieListChildCoordinator!
    
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        viewControllerUnderTest = storyboard.instantiateViewController(identifier: "\(MovieListViewController.self)")
        navigationController = UINavigationController()
        parentCoordinator = MainCoordinator.init(with: navigationController)
        movieListChildCoordinator = MovieListChildCoordinator.init(with: parentCoordinator.navigationController)
        movieListChildCoordinator.parentCoordinator = parentCoordinator
        
        viewControllerUnderTest.loadViewIfNeeded()
        movieListViewModel = MovieListViewModel(useCase: movieUseCase)
        viewControllerUnderTest.movieListChildCoordinator = movieListChildCoordinator
    }
    
    override func tearDown() {
        viewControllerUnderTest = nil
        movieListViewModel = nil
        super.tearDown()
    }
    
    func testOutletsShouldBeConnected() {
        XCTAssertNotNil(viewControllerUnderTest.tableView, "tableView")
        XCTAssertNotNil(viewControllerUnderTest.searchBar, "searchBar")
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }
}
