//
//  ApplicationConfiguration.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation

enum AppConfigConstants {
    static let APIKey = "APIKey"
    static let APIEndPoint = "APIEndpoint"
    static let ImageEndpoint = "ImageEndpoint"
}

enum ApplicationConfiguration {
    
    static var apiKey: String {
        var apiKey = ""
        do {
            apiKey = try Configuration.value(for: AppConfigConstants.APIKey) as String
        } catch(let error) {
            debugPrint("Error :\(error)")
        }
        return apiKey
    }
    
    static var apiEndpoint: String {
        var apiEndpoint = ""
        do {
            apiEndpoint = try Configuration.value(for: AppConfigConstants.APIEndPoint) as String
        } catch(let error) {
            debugPrint("Error :\(error)")
        }
        return apiEndpoint
    }
    
    static var imageEndpoint: String {
        var imageEndpoint = ""
        do {
            imageEndpoint = try Configuration.value(for: AppConfigConstants.ImageEndpoint) as String
        } catch(let error) {
            debugPrint("Error :\(error)")
        }
        return imageEndpoint
    }
}

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }
        
        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}
