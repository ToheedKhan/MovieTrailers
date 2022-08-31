//
//  NetworkManager.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation
import PromiseKit

final class NetworkManger: NetworkManagerProtocol {
    
    private let requestCreator: NetworkRequestCreator!
    private let session: URLSession
    
    init(requestCreator: NetworkRequestCreator, session: URLSession = .shared) {
        self.requestCreator = requestCreator
        self.session = session
    }
    
    func request<T: Decodable>(_ type: T.Type, endPoint: INetworkRequest) -> Response<T> {
        return Promise { seal in
            var request: URLRequest!
            do {
                request = try requestCreator.createURLRequest(using: endPoint)
            } catch {
                seal.reject(error)
                return
            }
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    seal.reject(error)
                } else {
                    do {
                        guard let receivedData = data else {
                            return
                        }
                        let decodedObject = try JSONDecoder().decode(type, from: receivedData)
                        seal.fulfill(decodedObject)
                    } catch {
                        seal.reject(error)
                    }
                }
            }
            task.resume()
        }
    }
}
