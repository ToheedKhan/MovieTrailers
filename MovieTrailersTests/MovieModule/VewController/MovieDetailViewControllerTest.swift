//
//  MovieDetailViewControllerTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 16/07/22.
//

@testable import MovieTrailers
import XCTest

final class MovieDetailViewControllerTests: XCTestCase {
    
    var viewController : MovieDetailViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        viewController = storyboard.instantiateViewController(identifier: "\(MovieDetailViewController.self)")
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(viewController.overviewTextView, "overviewTextView")
        XCTAssertNotNil(viewController.posterImageView, "posterImageView")
    }
}
