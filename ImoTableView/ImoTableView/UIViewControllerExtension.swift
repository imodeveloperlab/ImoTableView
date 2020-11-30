//
//  UIViewControllerExtension.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    /// Hide keyboard when tapped around
    func hideKeyboardWhenTappedAround(cancelsTouchesInView: Bool = false) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = cancelsTouchesInView
        view.addGestureRecognizer(tap)
    }
    
    ///Dismiss Keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
