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
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        viewControllerUnderTest = storyboard.instantiateViewController(identifier: "\(MovieListViewController.self)")
        viewControllerUnderTest.viewModel = MovieListViewModelImpl(useCase: MockFetchMovieUseCase(), outputDelegate: nil)
        viewControllerUnderTest.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewControllerUnderTest = nil
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
