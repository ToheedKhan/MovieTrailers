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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
 
    func configure(viewModel: MovieListCellViewModel) {
        // load image
        if let posterImagePath = viewModel.posterImagePath {
            posterImageView.loadImage(urlString: ApplicationConfiguration.imageEndpoint + posterImagePath)
        } else {
            //To load default image
            posterImageView.loadImage(urlString: nil)
        }
        
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
        rateLabel.text = viewModel.rate
        voteCountLabel.text = viewModel.voteCount
        popularityLabel.text = viewModel.popularity
    }
}
