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
    
    @IBOutlet weak var overviewTextView: UITextView!
    
    //MARK:- Variable & Constants:
    
    //MARK:- View Model
    var viewModel: MovieDetailViewModel?
      
    //MARK:- Life Cycle:-
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
 
    //MARK:- To Load Fonts
    private func loadFontsAndColor(){
        self.overviewTextView.font = UIFont.fonts(name: .meduim, size: .size_l)
        self.overviewTextView.textColor = primaryColor
    }
    
    private func setup(){
        self.navigationItem.title = viewModel?.movieTitle
        self.overviewTextView.text = viewModel?.overview
        self.view.accessibilityIdentifier = MovieSceneAccessibilityIdentifier.movieDetailsView
        //load image
        if let posterImagePath = viewModel?.posterImagePath {
            posterImageView.loadImage(urlString: ApplicationConfiguration.imageEndpoint + posterImagePath)
        } else { //To load default image
            posterImageView.loadImage(urlString: nil)
        }
    }
}
