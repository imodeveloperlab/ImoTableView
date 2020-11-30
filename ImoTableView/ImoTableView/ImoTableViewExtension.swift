//
//  ImoTableViewExtension.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import UIKit

public extension ImoTableView {
    
    /// Set table view contentInset and scrollIndicatorInsets to UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    func zeroContentInsets() {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.contentInset = insets
        self.tableView.scrollIndicatorInsets = insets
    }
    
    /// Should or not adjust table content offest when keyboard apears on screen
    ///
    /// - Parameter should: Bool
    func adjustContentInsetsForKeyboard(_ should: Bool) {
        
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
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidChangeFrame),
                                               name: UIResponder.keyboardDidChangeFrameNotification,
                                               object: nil)
    }
    
    /// Remove keyboard notifications observers
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// Keyboard will show notification
    ///
    /// - Parameter notification: Notification
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if isKeyboardOnScreen == false {
            storedContentInset = self.tableView.contentInset
            storedScrollIndicatorInsets = self.tableView.scrollIndicatorInsets
            isKeyboardOnScreen = true
            adjustScroll(for: notification)
        }
    }
    
    /// Keyboard will hide notification
    ///
    /// - Parameter notification: Notification
    @objc func keyboardWillHide(_ notification: Notification) {
        
        isKeyboardOnScreen = false
        adjustScroll(for: notification)
    }
    
    /// Keyboard will hide notification
    ///
    /// - Parameter notification: Notification
    @objc func keyboardDidChangeFrame(_ notification: Notification) {
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
        
        guard let keyboargFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return nil
        }
        
        return (frame: keyboargFrame, duration: duration)
    }
    
    /// Get UIEdgeInsets for keyboardFrame
    ///
    /// - Parameter keyboardFrame: CGRect
    /// - Returns: UIEdgeInsets
    func insets(for keyboardFrame: CGRect) -> UIEdgeInsets {
        
        if isKeyboardOnScreen {
            
            guard let view = self.superview,
                  let mainWindowView = mainWindowView() else {
                return self.tableView.contentInset
            }
            
            let tableFrame = self.tableView.frame
            let convertedTableFrame = view.convert(tableFrame, to: view)
            let inset = keyboardFrame.intersection(convertedTableFrame).height
            let currentTableInsets = self.tableView.contentInset
            let topMargin = view.frame.size.height - (self.frame.size.height + self.frame.origin.y)
            let difference = mainWindowView.frame.size.height - self.frame.size.height - topMargin
            
            var bottomSafeArea: CGFloat = 0
            
            if #available(iOS 11.0, *) {
                if let bottom = superview?.safeAreaInsets.bottom {
                    bottomSafeArea = bottom
                }
            }
            
            let insetts = UIEdgeInsets(top: currentTableInsets.top,
                                       left: currentTableInsets.left,
                                       bottom: inset + difference - bottomSafeArea,
                                       right: currentTableInsets.right)
            return insetts
            
        } else {
            
            if let storedContentInset = self.storedContentInset {
                return storedContentInset
            }
            
            return self.tableView.contentInset
        }
    }
    
    /// Get top view from window
    ///
    /// - Returns: most top view from window
    func mainWindowView() -> UIView? {
        
        guard let controller = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }
        
        guard (controller.navigationController != nil) else {
            return controller.view
        }
        
        return controller.navigationController?.view
    }
    
    func spaceBetwenLastCellAndTableBottom() -> CGFloat {
        
        tableView.layoutIfNeeded()
        let difference = self.tableView.frame.size.height - tableView.contentSize.height
        
        if difference > 0 {
            return difference
        } else {
            return 0
        }
    }
}

public extension ImoTableView {
    
    func scrollToCell(source: ImoTableViewSource,
                      at scrollPosition: UITableView.ScrollPosition,
                      animated: Bool) {
        
        if let indexPath = indexPathsFor(source: source) {
            
            tableView.scrollToRow(at: indexPath,
                                  at: scrollPosition,
                                  animated: animated)
        }
    }
}
