//
//  MovieTableCell.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import UIKit

final class MovieTableCell: UITableViewCell {
    static let reuseIdentifier = String(describing: MovieTableCell.self)
    
    //MARK:- Layout:-
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var popularity: UILabel!
    
    //Text Labels
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    func configure(viewModel: MovieListCellViewModel) {
        // load image
        if let posterImagePath = viewModel.posterImagePath {
            posterImageView.loadImage(urlString: ApplicationConfiguration.imageEndpoint + posterImagePath)
        } else {
            //To load default image
            posterImageView.loadImage(urlString: nil)
        }
        
        movieTitle.text = viewModel.title
        releaseDate.text = viewModel.releaseDate
        rate.text = viewModel.rate
        voteCount.text = viewModel.voteCount
        popularity.text = viewModel.popularity
    }
}
