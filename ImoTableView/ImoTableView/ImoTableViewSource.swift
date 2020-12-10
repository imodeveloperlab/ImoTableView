//
//  ImoTableViewSource.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import Foundation
import UIKit

open class ImoTableViewSource: NSObject {

    /// Static cell
    public var staticCell: ImoTableViewCell?
    
    ///Manual cell height
    public var height: CGFloat?
    
    ///Cell class / identifier
    var cellClass: String
    
    ///Cell any class
    var cellAnyClass: AnyClass?
    
    ///Target to send messages to Selector from cell
    weak public var target: AnyObject?
    
    //Selector for add action to an button inside cell
    public var selector: Selector?
    
    //Custom sender object
    public var object: AnyObject?
    
    //Cell xib
    open var nib: UINib?
    
    //Can cell be edited
    public var canBeEdited: Bool = false
    
    //Title for delete button
    public var deleteButtonTitle: String?
    
    //Accessibility Identifier
    open var accessibilityIdentifier: String?
    
    open var isSeparatorEnabled: Bool = true
    
    open var estimatedHeightForRow: CGFloat = 40
    
    /// Init source
    ///
    /// - Parameter cellClass: Cell class / identifier
    public init(cellClass: String, cellAnyClass: AnyClass? = nil) {
        self.cellClass = cellClass
        self.cellAnyClass = cellAnyClass
        self.nib = UINib(nibName: self.cellClass, bundle: nil)
        super.init()
    }
    
    /// Set nib bundle
    public func setNibBundle(with bundle:Bundle) {
        self.nib = UINib(nibName: self.cellClass, bundle: bundle)
    }
}
