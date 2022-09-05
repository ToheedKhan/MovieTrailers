//
//  NetworkRequest.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation

protocol INetworkRequest {
    var path: String { get set }
    var method: HTTPMethod { get set }
    var headerParamaters: [String: String] { get set }
    var queryParameters: [String: Any] { get set }
}

enum NetworkConstants {
    static let timeoutInterval = 10.0
}

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

// MARK: - API class will help to define the APIs in the remote networking when calling from the server
struct NetworkRequest: INetworkRequest {
    
    var path: String
    var method: HTTPMethod
    var headerParamaters: [String: String]
    var queryParameters: [String: Any]
    
    init(path: String,
         method: HTTPMethod,
         headerParamaters: [String: String] = [:],
         queryParameters: [String: Any] = [:]) {
        self.path = path
        self.method = method
        self.headerParamaters = headerParamaters
        self.queryParameters = queryParameters
    }
}

//MARK: - For URL creation
extension INetworkRequest {
    
    func createURLRequest(using endPoint: INetworkRequest) throws -> URLRequest {
        do {
            let url = try createURL(with: endPoint)
            var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: NetworkConstants.timeoutInterval)
            urlRequest.httpMethod = endPoint.method.rawValue
            endPoint.headerParamaters.forEach({ key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            })
            return urlRequest
        } catch {
            throw error
        }
    }
    
    private func createURL(with endPoint: INetworkRequest) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = ApplicationConfiguration.apiEndpoint
        components.path = endPoint.path
        components.queryItems = endPoint.queryParameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        
        guard let url = components.url else {
            throw NSError(domain: "URL", code: NSURLErrorBadURL, userInfo: nil)
        }
        return url
    }
}
