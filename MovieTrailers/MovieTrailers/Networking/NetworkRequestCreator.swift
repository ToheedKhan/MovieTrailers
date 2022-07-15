//
//  NetworkRequestCreator.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation

struct NetworkConstants {
    static let timeoutInterval = 10.0
}

var scheme: String {
    return "https"
}

class NetworkRequestCreator {
    
    func createURLRequest(using endPoint: INetworkRequest) throws -> URLRequest {
        do {
            let url = try createURL(with: endPoint)
            var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: NetworkConstants.timeoutInterval)
            urlRequest.httpMethod = endPoint.method.rawValue
            if !endPoint.bodyParamaters.isEmpty {
                let bodyData = try? JSONSerialization.data(withJSONObject: endPoint.bodyParamaters, options: [.prettyPrinted])
                urlRequest.httpBody = bodyData
            }
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
        components.scheme = endPoint.scheme
        components.host = getHost(type: endPoint.hostType)
        components.path = endPoint.path
        components.queryItems = endPoint.queryParameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        
        guard let url = components.url else {
            // Currently not writing the custom errors so directly Writing NSError, for others depending currently for the error returned by service.
            throw NSError(domain: "URL", code: NSURLErrorBadURL, userInfo: nil)
        }
        return url
    }
    
    private func getHost(type: RequestHostType) -> String {
        if type == .data {
            return ApplicationConfiguration.apiEndpoint
        }
        return ApplicationConfiguration.imageEndpoint
    }
}
