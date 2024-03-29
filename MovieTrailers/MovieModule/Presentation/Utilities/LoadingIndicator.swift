//
//  LoadingIndicator.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 30/06/22.
//

import UIKit

final class LoadingIndicator: UIView {
    
    public static var shared = LoadingIndicator()
    
    private var indicator : UIActivityIndicatorView =  {
        
        let indicator = UIActivityIndicatorView()
        indicator.backgroundColor = .clear
        
        if #available(iOS 13.0, *) {
            indicator.style = .large
        } else {
            // Fallback on earlier versions
            indicator.style = .whiteLarge
        }
        //        indicator.textInputMode = ""
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
        
    }()
    
    func show(for view: UIView)  {
        let sizeOfIndicator = view.bounds.size.width / 6.9
        indicator.startAnimating()
        view.addSubview(indicator)
        //        indicator.frame = CGRect(x: view.center.x, y: view.center.y, width: 60, height: 60)
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: sizeOfIndicator).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: sizeOfIndicator).isActive = true
        indicator.bringSubviewToFront(view)
    }
    
    func hide (){
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
        }
    }
}


