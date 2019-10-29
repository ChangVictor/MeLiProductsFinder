//
//  UIViewController.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 27/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alertMessage(message: String, title: String = "") {
    
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
    
        self.present(alertController, animated: true, completion: nil)
    }
}
