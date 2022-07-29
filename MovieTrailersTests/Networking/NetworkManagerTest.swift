//
//  NetworkManagerTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 15/07/22.
//

import XCTest
@testable import MovieTrailers

final class NetworkManagerTest: XCTestCase {
    
    var networkManager: NetworkManagerProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        networkManager = NetworkManger(requestCreator: NetworkRequestCreator(), session: urlSession)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_NetworkClassForSuccess() {
        
        let promise = expectation(description: "Should get success")
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                throw NSError(domain: "URL", code: NSURLErrorBadURL, userInfo: nil)
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, MockData.mockMovieResponseData())
        }
        
        let endPoint = NetworkRequest(path: "/movie", method: .get)
        networkManager.request(MovieList.self, endPoint: endPoint)
            .done { model in
                let movieCount = model.movies.count
                if movieCount >= 1 {
                    XCTAssertTrue(model.movies.first?.title == "Doctor Strange in the Multiverse of Madness")
                    promise.fulfill()
                }
            }.catch { error in
                XCTFail("test_NetworkClassForSuccess - Movies couldn't fetch successfully. Error was not expected: \(error)")
                promise.fulfill()
            }
        
        wait(for: [promise], timeout: 1.0)
    }
    
    func test_NetworkClassForURLFailure() {
        
        let promise = expectation(description: "Should get URL Failure")
        
        let endPoint = NetworkRequest(path: "-;@,?:ą", method: .get)
        networkManager.request(MovieList.self, endPoint: endPoint)
            .catch { error in
                XCTAssertTrue((error as NSError).domain == "URL")
                promise.fulfill()
            }
        
        wait(for: [promise], timeout: 1.0)
    }
    
    func test_ParsingFailure() {
        let promise = expectation(description: "Parsing Failure")
        // Prepare response
        let data = Data()
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        let endPoint = NetworkRequest(path: "/movie", method: .get)
        networkManager.request(Movie.self, endPoint: endPoint)
            .done { model in
                XCTFail("Success response was not expected.")
            }.catch { error in
                promise.fulfill()
            }
        wait(for: [promise], timeout: 1.0)
    }
    
}
