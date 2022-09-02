//
//  AppDI.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 21/08/22.
//

import Foundation

final class AppDI {
    lazy var networkManager: NetworkManagerProtocol = {
        let networkManager = NetworkManger(requestCreator: NetworkRequestCreator())
        return networkManager
    }()
}
