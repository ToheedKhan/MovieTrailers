//
//  AppContainer.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 14/07/22.
//

import UIKit

class AppCoordinator {
    
    lazy var networkManager: NetworkManagerProtocol = {
        let networkManager = NetworkManger(requestCreator: NetworkRequestCreator())
        return networkManager
    }()
    
    // Starting app here only we could separate out the Files if we need
    
    func start(on window: UIWindow?) {
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let module = MovieModule(networkManager: networkManager)
        let movieFlow = module.createMovieFlowCoordinator(navigationController: navigationController)
            movieFlow.start()
        
        
    }
}
