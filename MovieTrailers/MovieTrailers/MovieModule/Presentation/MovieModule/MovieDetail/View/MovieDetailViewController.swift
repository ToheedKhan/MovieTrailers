//
//  MovieDetailViewController.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 30/06/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
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
        self.overviewTextView.textColor = DesignSystem.Colors.primary.color
    }
    
    private func setup(){
        let posterImageUrl = ApplicationConfiguration.imageEndpoint + (viewModel?.posterImagePath ?? "")
        self.navigationItem.title = viewModel?.movieTitle
        self.overviewTextView.text = viewModel?.overview
        posterImageView.loadImage(urlString: posterImageUrl)
    }
    
}
