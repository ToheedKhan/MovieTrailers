//
//  AppContainer.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 14/07/22.
//

import Foundation
import UIKit

class AppContainer {
    
    lazy var networkManager: NetworkManagerProtocol = {
        let networkManager = NetworkManger(requestCreator: NetworkRequestCreator())
        return networkManager
    }()
    
    // Starting app here only we could separate out the Files if we need
    
    func startApp(on window: UIWindow?) {
        let module = MovieModule(networkManager: networkManager)
        let controller = module.createMovieListViewController()
        let nvc: UINavigationController = UINavigationController(rootViewController: controller)
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
    }
    
}
