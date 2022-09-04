//
//  MovieDetailViewController.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 30/06/22.
//

import UIKit

final class MovieDetailViewController: UIViewController, ColorProvider {
    
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
    //To Load Fonts
    private func loadFontsAndColor(){
        self.overviewLabel.font = UIFont.font(size: .headline)
        self.overviewLabel.textColor = primaryDarkColor
    }
    
    private func setupUI(){
        self.navigationItem.title = viewModel.movieTitle
        self.overviewLabel.text = viewModel.overview
        self.view.accessibilityIdentifier = MovieSceneAccessibilityIdentifier.movieDetailsView
        posterImageView.addShadoweffect()
        loadFontsAndColor()
        //load image
        if let posterImagePath = viewModel.posterImagePath {
            posterImageView.loadImage(urlString: ApplicationConfiguration.imageEndpoint + posterImagePath)
        } else { //To load default image
            posterImageView.loadImage(urlString: nil)
        }
    }
}
