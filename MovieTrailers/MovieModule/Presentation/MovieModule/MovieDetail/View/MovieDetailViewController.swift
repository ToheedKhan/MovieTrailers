//
//  MovieDetailViewController.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 30/06/22.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    //MARK:- Layout:-
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    //MARK:- View Model
    var viewModel: MovieDetailViewModel!
    
    //MARK:- Life Cycle:-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK:- Private Methods
    private func setupUI(){
        self.navigationItem.title = viewModel.title
        self.overviewLabel.text = viewModel.overview
        self.view.accessibilityIdentifier = MovieSceneAccessibilityIdentifier.movieDetailsView
        posterImageView.addShadoweffect()
        //load image
        if let posterImagePath = viewModel.posterImagePath {
            posterImageView.loadImage(urlString: ApplicationConfiguration.imageEndpoint + posterImagePath)
        } else { //To load default image
            posterImageView.loadImage(urlString: nil)
        }
    }
}
