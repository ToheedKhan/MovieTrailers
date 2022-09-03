//
//  UISearchBar+Extension.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 03/09/22.
//

import UIKit

extension UISearchBar: ColorProvider {
    func customizeUISearchBarAppereance() {
        // Change the Tint Color
        self.barTintColor = AppTheme.primaryTheme
        self.tintColor = UIColor.white
        // Show/Hide Cancel Button
        self.showsCancelButton = true
        self.keyboardAppearance = .dark
        // Change TextField Colors
        self.searchTextField.textColor = UIColor.white
        self.searchTextField.backgroundColor = headerLightColor
        self.searchTextField.clearButtonMode = .never
        self.searchTextField.clearButtonMode = .whileEditing
    }
    
    func customizeSearchBarTextFieldPosition(offset: Int) {
        if let newPosition = self.searchTextField.position(from: searchTextField.beginningOfDocument, in: UITextLayoutDirection.down, offset: offset) {
            searchTextField.selectedTextRange = searchTextField.textRange(from: newPosition, to: newPosition)
        }
    }
    
    func addClearButton(action: Selector, target: UIViewController) {
        if let searchTextField = self.value(forKey: "searchField") as? UITextField , let clearButton = searchTextField.value(forKey: "_clearButton")as? UIButton {
            
            clearButton.addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    func chageGlassIconView(tintColor: UIColor) {
        let glassIconView = self.searchTextField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = tintColor
    }
}
