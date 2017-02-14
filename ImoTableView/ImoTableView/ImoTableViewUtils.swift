//
//  ImoTableViewUtis.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 2/14/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import UIKit
import Foundation

public extension UIView {
    
    func edgesConstraints(to view:UIView, insets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let top = alignConstraint(view: view, alignTo: self, attribute: .top, inset: insets.top)
        let bottom = alignConstraint(view: view, alignTo: self, attribute: .bottom, inset: insets.bottom)
        let left = alignConstraint(view: view, alignTo: self, attribute: .left, inset: insets.left)
        let right = alignConstraint(view: view, alignTo: self, attribute: .right, inset: insets.right)
        self.addConstraints([top, bottom, left, right])
    }
    
    func alignConstraint(view:UIView, alignTo:UIView, attribute:NSLayoutAttribute, inset:CGFloat) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(item: view,
                                  attribute: attribute,
                                  relatedBy: NSLayoutRelation.equal,
                                  toItem: alignTo, attribute: attribute,
                                  multiplier: 1,
                                  constant: inset)
    }
}
