//
//  ImoTableViewUtis.swift
//  ImoTableView
//
//  Created by Winify AG on 2/14/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import UIKit
import Foundation

public extension UIView {
    
    func edgesConstraints(to view:UIView, insets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let topProperties = ImoTableViewConstraintProprietes(view: view, alignTo: self, attribute: .top, inset: insets.top)
        let top = alignConstraint(topProperties)

        let bottomProperties = ImoTableViewConstraintProprietes(view: view, alignTo: self, attribute: .bottom, inset: insets.bottom)
        let bottom = alignConstraint(bottomProperties)
        
        let leftProperties = ImoTableViewConstraintProprietes(view: view, alignTo: self, attribute: .left, inset: insets.left)
        let left = alignConstraint(leftProperties)
        
        let rightProperties = ImoTableViewConstraintProprietes(view: view, alignTo: self, attribute: .right, inset: insets.right)
        let right = alignConstraint(rightProperties)
        
        self.addConstraints([top, bottom, left, right])
    }
    
    func alignConstraint(_ proprietes: ImoTableViewConstraintProprietes) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(item: proprietes.view,
                                  attribute: proprietes.attribute,
                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                  toItem: proprietes.alignTo, attribute: proprietes.attribute,
                                  multiplier: 1,
                                  constant: proprietes.inset)
    }
}

public struct ImoTableViewConstraintProprietes {
    
    var view: UIView
    var alignTo: UIView
    var attribute: NSLayoutConstraint.Attribute
    var inset: CGFloat
}
