//
//  MovieDetailChildCoordinator.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 16/08/22.
//

import UIKit

final class MovieDetailChildCoordinator : ChildCoordinator {
    weak var parentCoordinator: ParentCoordinator?
    
    var navigationController: UINavigationController
    
    private var viewModel: MovieDetailViewModel?
    
    init(with _navigationController : UINavigationController){
        self.navigationController = _navigationController
    }
    
    func configureChildViewController() {
        let movieDetailVC = MovieDetailDI().createMovieDetailViewController()
        if let detailVM = viewModel {
            movieDetailVC.viewModel = detailVM
        }
        self.navigationController.pushViewController(movieDetailVC, animated: true)
    }
    
    func passParameter(value: Decodable) {
        guard let vm = value as? MovieListCellViewModel else { return }
        self.viewModel = MovieDetailDI().createMovieDetailViewModel(with: vm)
    }
}

