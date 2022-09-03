//
//  MovieTableCell.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import UIKit

final class MovieTableCell: UITableViewCell, ColorProvider {
    static let reuseIdentifier = String(describing: MovieTableCell.self)
    static let height = (UIDevice.current.userInterfaceIdiom == .pad)
                                             ? CGFloat(170)
                                             : CGFloat(150)

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
    
    //MARK:- View Model Movie cell
    var cellViewModel: MovieListCellViewModel? {
        didSet {
            self.loadData()
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            // Update the cell
            DispatchQueue.main.async {
                self.loadFonts()
                self.applyColors()
            }
        }
    }
    
    //MARK:- To Load Fonts
    private func loadFonts(){
        movieTitle.font = UIFont.font(weight: .semiBold, size: .title)
        releaseDate.font = UIFont.font(size: .headline)
        rate.font = UIFont.font(size: .headline)
        voteCount.font = UIFont.font(size: .headline)
        popularity.font = UIFont.font(size: .headline)
        
        popularityLabel.font = UIFont.font(size: .headline)
        rateLabel.font = UIFont.font(size: .headline)
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

//MARK:- Network:-
extension MovieTableCell {
    
    //MARK:- Load Data
    private func loadData(){
        //load image
        if let posterImagePath = cellViewModel?.posterImagePath {
            posterImageView.loadImage(urlString: ApplicationConfiguration.imageEndpoint + posterImagePath)
        } else { //To load default image
            posterImageView.loadImage(urlString: nil)
        }
        
        movieTitle.text = cellViewModel?.title
        releaseDate.text = cellViewModel?.releaseDate
        rate.text = cellViewModel?.rate
        voteCount.text = cellViewModel?.voteCount
        popularity.text = cellViewModel?.popularity
    }
}

