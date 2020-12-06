//
//  ImoTableViewUtils.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import UIKit
import Foundation

public extension UIView {
    
    func edgesConstraints(to view:UIView, insets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let topProperties = ImoTableViewConstraintProperties(view: view, alignTo: self, attribute: .top, inset: insets.top)
        let top = alignConstraint(topProperties)
        
        let bottomProperties = ImoTableViewConstraintProperties(view: view, alignTo: self, attribute: .bottom, inset: insets.bottom)
        let bottom = alignConstraint(bottomProperties)
        
        let leftProperties = ImoTableViewConstraintProperties(view: view, alignTo: self, attribute: .left, inset: insets.left)
        let left = alignConstraint(leftProperties)
        
        let rightProperties = ImoTableViewConstraintProperties(view: view, alignTo: self, attribute: .right, inset: insets.right)
        let right = alignConstraint(rightProperties)
        
        self.addConstraints([top, bottom, left, right])
    }
    
    func alignConstraint(_ properties: ImoTableViewConstraintProperties) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(item: properties.view,
                                  attribute: properties.attribute,
                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                  toItem: properties.alignTo, attribute: properties.attribute,
                                  multiplier: 1,
                                  constant: properties.inset)
    }
}

public struct ImoTableViewConstraintProperties {
    
    var view: UIView
    var alignTo: UIView
    var attribute: NSLayoutConstraint.Attribute
    var inset: CGFloat
}
