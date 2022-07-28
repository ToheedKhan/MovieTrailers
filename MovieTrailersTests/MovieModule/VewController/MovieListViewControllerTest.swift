//
//  MovieListViewControllerTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 16/07/22.
//

@testable import MovieTrailers
import XCTest

final class MovieListViewControllerTests: XCTestCase {
    
    var viewController : MovieListViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        viewController = storyboard.instantiateViewController(identifier: "\(MovieListViewController.self)")
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(viewController.tableView, "tableView")
        XCTAssertNotNil(viewController.searchBar, "searchBar")
    }
}
