//
//  UIViewControllerExtension.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 5/10/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    /// Hide keyboard when tapped around
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    ///Dismiss Keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
