//
//  MovieTrailersUITests.swift
//  MovieTrailersUITests
//
//  Created by Toheed Jahan Khan on 11/07/22.
//

import XCTest

class MovieTrailersUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func test_TableView() {
        app.launch()
        
        let movieTableView = app.tables[MovieSceneAccessibilityIdentifier.movieTableView]
        
        XCTAssertTrue(movieTableView.exists, "The movie tableview exists")
        
        let tableCells = movieTableView.cells
        XCTAssert(tableCells.element.waitForExistence(timeout: 5.0))
        //        let cell = tableCells.element(boundBy: 0)
        //        XCTAssert(cell.waitForExistence(timeout: 5.0))
        
        if tableCells.count > 0 {
            //Loop through only first 2 cell.
            let count: Int = (tableCells.count > 2) ? 2 : (tableCells.count - 1)
            
            let promise = expectation(description: "Wait for table cells")
            
            for i in stride(from: 0, to: count , by: 1) {
                // Grab the first cell and verify that it exists and tap it
                let tableCell = tableCells.element(boundBy: i)
                XCTAssertTrue(tableCell.waitForExistence(timeout: 2.0), "The \(i) cell is in place on the table")
                movieTableView.scrollToElement(element: tableCell)
                if i == (count - 1) {
                    promise.fulfill()
                }
                // Back
            }
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
            
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
    }
    
//        func testOpenMovieDetails_whenSearchDogAndTapOnFirstResultRow_thenMovieDetailsViewOpensWithTitleDog() {
//
//            let app = XCUIApplication()
//
//            // Search for Dog
//            let searchText = "Dog"
//            let x = app.searchFields[MovieSceneAccessibilityIdentifier.searchField]
//            app.searchFields[MovieSceneAccessibilityIdentifier.searchField].tap()
//            if !app.keys["A"].waitForExistence(timeout: 10) {
//                XCTFail("The keyboard could not be found. Use keyboard shortcut COMMAND + SHIFT + K while simulator has focus on text input")
//            }
//            _ = app.searchFields[MovieSceneAccessibilityIdentifier.searchField].waitForExistence(timeout: 15)
//            app.searchFields[MovieSceneAccessibilityIdentifier.searchField].typeText(searchText)
//            app.buttons["search"].tap()
//
//            // Tap on first result row
//            app.tables.cells.staticTexts[searchText].tap()
//
//            // Make sure movie details view
//            XCTAssertTrue(app.otherElements[MovieSceneAccessibilityIdentifier.movieDetailsView].waitForExistence(timeout: 5))
//            XCTAssertTrue(app.navigationBars[searchText].waitForExistence(timeout: 5))
//        }
}

extension XCUIElement {
    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
