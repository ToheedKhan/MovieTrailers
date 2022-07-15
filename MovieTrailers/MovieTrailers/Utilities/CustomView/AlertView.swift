//
//  AlertView.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 01/07/22.
//

import UIKit

public protocol Alertable {}

enum AlertType {
    case error
    case empty
}

class AlertView: UIView {
    
    //MARK:- Layout:-
    @IBOutlet private weak var iconImageview: UIImageView!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!

    //MARK:- Init Func
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let _ =   self.instanceFromNib(name: "AlertView")
        loadFonts()
    }
    
    //MARK:- IBActions
    @IBAction func onClickButtonOK() {
        
    }
}

public extension Alertable where Self: UIViewController {
    
    func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
    
//    func showAlert(title: String = "Notice", message: String, completion:(() -> Void)? = nil) {
//        let alert = AlertView()
//    }
}

extension AlertView {
    
    private func loadFonts(){
        self.messageLabel.font = UIFont.fonts(name: .regular, size: .size_xl)
    }
    
    func loadAlert(_ type: AlertType = .error){
        switch type {
        case .error:
            self.messageLabel.text = "Something went wrong !!"
            self.iconImageview.image = UIImage(named: "error")
        case .empty:
            self.messageLabel.text = "No data found !!"
            self.iconImageview.image = UIImage(named: "empty")
        }
    }
    
}
