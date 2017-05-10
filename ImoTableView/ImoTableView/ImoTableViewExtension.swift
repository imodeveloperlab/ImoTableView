//
//  ImoTableViewExtension.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 5/9/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import UIKit

public extension ImoTableView {
    
    /// Set table view contentInset and scrollIndicatorInsets to UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    public func zeroContentInsets() {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.contentInset = insets
        self.tableView.scrollIndicatorInsets = insets
    }
    
    /// Should or not adjust table content offest when keyboard apears on screen
    ///
    /// - Parameter should: Bool
    public func adjustContentInsetsForKeyboard(_ should: Bool) {
        
        if should {
            addKeyboardObservers()
        } else {
            removeKeyboardObservers()
        }
    }
    
    /// Add observers
    func addKeyboardObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    /// Remove keyboard notifications observers
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// Keyboard will show notification
    ///
    /// - Parameter notification: Notification
    func keyboardWillShow(_ notification: Notification) {
        
        storedContentInset = self.tableView.contentInset
        storedScrollIndicatorInsets = self.tableView.scrollIndicatorInsets
        adjustScroll(for: notification)
    }
    
    /// Keyboard did show notification
    ///
    /// - Parameter notification: Notification
    func keyboardDidShow(_ notification: Notification) {
        adjustScroll(for: notification)
    }
    
    /// Keyboard will hide notification
    ///
    /// - Parameter notification: Notification
    func keyboardWillHide(_ notification: Notification) {
        adjustScroll(for: notification)
    }
    
    /// Adjust scroll for notification
    ///
    /// - Parameter notification: Notification
    func adjustScroll(for notification: Notification) {
        
        if let frameAndDuration = self.framAndDuration(for: notification) {
            
            let frame = frameAndDuration.frame
            let duration = frameAndDuration.duration
            let newTableInsets = insets(for: frame)
            
            UIView.animate(withDuration: duration, animations: {
                self.tableView.contentInset = newTableInsets
                self.tableView.scrollIndicatorInsets = newTableInsets
            })
        }
    }
    
    /// Get keyboard frame and animation duration from notification
    ///
    /// - Parameter notification: Notification
    /// - Returns: (frame: CGRect, duration: Double)?
    func framAndDuration(for notification: Notification) -> (frame: CGRect, duration: Double)? {
        
        if let userInfo = notification.userInfo {
            if let keyboargFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect {
                if let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double {
                    return (frame: keyboargFrame, duration: duration)
                }
            }
        }
        
        return nil
    }
    
    /// Get UIEdgeInsets for keyboardFrame
    ///
    /// - Parameter keyboardFrame: CGRect
    /// - Returns: UIEdgeInsets
    func insets(for keyboardFrame: CGRect) -> UIEdgeInsets {
        
        if let view = mainView() {
            
            let tableFrame = self.tableView.frame
            let convertedTableFrame = tableView.convert(tableFrame, to: view)
            let inset = keyboardFrame.intersection(convertedTableFrame).height
            
            let currentTableInsets = self.tableView.contentInset
            
            return UIEdgeInsets(top: currentTableInsets.top,
                                left: currentTableInsets.left,
                                bottom: inset,
                                right: currentTableInsets.right)
        }
        
        if let storedContentInset = self.storedContentInset {
            return storedContentInset
        } else {
            return self.tableView.contentInset
        }
    }
    
    /// Get top view from window
    ///
    /// - Returns: most top view from window
    func mainView() -> UIView? {
        if let window = UIApplication.shared.keyWindow {
            if let controller = window.rootViewController {
                return controller.view
            }
        }
        return nil
    }
    
}
