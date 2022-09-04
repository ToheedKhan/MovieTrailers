//
//  MovieTableCell.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import UIKit

final class MovieTableCell: UITableViewCell, ColorProvider {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.loadFonts()
            self.applyColors()
        }
    }
  
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
    
    //MARK:- To Load Fonts
    private func loadFonts(){
        movieTitle.font = UIFont.font(weight: .semiBold, size: .title)
        releaseDate.font = UIFont.font(size: .headline)
        rate.font = UIFont.font(weight: .meduim, size: .headline)
        voteCount.font = UIFont.font(size: .headline)
        popularity.font = UIFont.font(size: .headline)
        
        popularityLabel.font = UIFont.font(size: .headline)
        rateLabel.font = UIFont.font(weight: .meduim, size: .headline)
        voteCountLabel.font = UIFont.font(size: .headline)
    }

    private func applyColors(){
        movieTitle.textColor = primaryTextColor
        releaseDate.textColor = primaryColor
        rate.textColor = primaryColor
        voteCount.textColor = primaryColor
        popularity.textColor = primaryColor

        popularityLabel.textColor = primaryColor
        voteCountLabel.textColor = primaryColor
        rateLabel.textColor = primaryColor
    }
}
