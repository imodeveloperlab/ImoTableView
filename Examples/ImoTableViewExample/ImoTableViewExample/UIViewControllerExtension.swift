//
//  UIViewControllerExtension.swift
//  ImoTableViewExample
//
//  Created by Borinschi Ivan on 6/1/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func show(message: String)  {
    
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
