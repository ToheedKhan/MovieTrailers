//
//  UIView+Extension.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 30/06/22.
//

import UIKit

extension UIView {
    
    func instanceFromNib(name: String) -> UIView {
        let bundle  = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: name , bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight , .flexibleWidth ]
        addSubview(view)
        return view
    }
    
    static var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
    static func instantiateFromNib() -> Self? {
        
        func instanceFromNib<T: UIView>() -> T? {
            return UINib(nibName: "\(self)", bundle: nil).instantiate() as? T
        }
        return instanceFromNib()
    }
    
}
extension UINib {
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}
