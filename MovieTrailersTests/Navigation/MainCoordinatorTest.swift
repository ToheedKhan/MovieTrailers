//
//  MainCoordinatorTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 17/08/22.
//

@testable import MovieTrailers
import XCTest

final class MainCoordinatorTest: XCTestCase {
    
    private var sut: MainCoordinator!
    private var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        
        navigationController
        = UINavigationController()
        sut = MainCoordinator.init(with: navigationController)
    }
    
    override func tearDown() {
        sut = nil
        navigationController = nil
        
        super.tearDown()
    }
    
    func test_whenConfigureRootVCCalled_thenMovieListVCAddedToNavigationStack() {
        sut.configureRootViewController()
        XCTAssertTrue(navigationController.children.last is MovieListViewController)
    }
    
    func test_whenRemoveChildCoordinator_thenMovieListVCPoppedFromNavigationStack() {
        sut.configureRootViewController()
        let movieChildCoordinator = sut.childCoordinators.last
        guard let childCoordinator = movieChildCoordinator  else { return }
        sut.removeChildCoordinator(child: childCoordinator)
        XCTAssertTrue(navigationController.children.last is MovieListViewController)
    }
}
