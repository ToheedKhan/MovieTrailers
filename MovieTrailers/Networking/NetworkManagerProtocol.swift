//
//  INetworkManager.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 12/07/22.
//

import Foundation
import PromiseKit

typealias Response<T> = Promise<T>

protocol NetworkManagerProtocol {
    func request<T: Decodable>(_ type: T.Type, endPoint: INetworkRequest) -> Response<T>
}
