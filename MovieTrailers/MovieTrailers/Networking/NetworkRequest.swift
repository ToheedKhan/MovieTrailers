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
    var hostType: RequestHostType { get set }
    var headerParamaters: [String: String] { get set }
    var queryParameters: [String: Any] { get set }
    var bodyParamaters: [String: Any] { get set }
}

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

enum RequestHostType: String {
    case image     = "Image"
    case data    = "data"
}

extension INetworkRequest {
    
    var scheme: String {
        return "https"
    }
}

// MARK: - API class will help to define the APIs in the remote networking when calling from the server
class NetworkRequest: INetworkRequest {
    
    var path: String
    var method: HTTPMethod
    var hostType: RequestHostType = .data
    var headerParamaters: [String: String]
    var queryParameters: [String: Any]
    var bodyParamaters: [String: Any]
    
    init(path: String,
         method: HTTPMethod,
         hostType: RequestHostType = .data,
         headerParamaters: [String: String] = [:],
         queryParameters: [String: Any] = [:],
         bodyParamaters: [String: Any] = [:]) {
        self.path = path
        self.method = method
        self.hostType = hostType
        self.headerParamaters = headerParamaters
        self.queryParameters = queryParameters
        self.bodyParamaters = bodyParamaters
    }
}
