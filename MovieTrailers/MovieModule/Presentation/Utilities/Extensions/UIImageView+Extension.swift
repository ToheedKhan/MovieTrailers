//
//  UIImageView+Extension.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 14/07/22.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func loadImage(urlString: String?){
        
        guard let imgUrlString = urlString else {
            self.image = UIImage(named: "defaultIMG")
            return
        }
        
        self.alpha = 0.0
        self.sd_setImage(with: URL(string: imgUrlString), placeholderImage: UIImage(named: "defaultIMG"), options: .highPriority, progress: { (value, toValue, nil) in
        }) { (_, _, _, _) in
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.alpha = 1.0
                self?.layoutIfNeeded()
            }
        }
    }
}
