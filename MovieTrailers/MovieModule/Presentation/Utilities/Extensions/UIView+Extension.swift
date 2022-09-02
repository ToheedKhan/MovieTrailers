//
//  UIView+Extension.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 02/09/22.
//

import UIKit

extension UIView {
    func addShadoweffect() {
        self.clipsToBounds = false
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.2
    }
}
