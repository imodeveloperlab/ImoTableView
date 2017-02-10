//
//  ActionCellCell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class ActionCellCellSource : ImoTableViewSource {
    
    public var title: String
    
    public init(title: String) {
        
        self.title = title
        
        super.init(cellClass: "ActionCellCell")
        self.nib = UINib(nibName: self.cellClass, bundle: Bundle.init(for: self.classForCoder))
        self.height = 80
    }
}

open class ActionCellCell : ImoTableViewCell {
    
    @IBOutlet weak var actionTitle: UILabel!
    open override func setUpWithSource(source:AnyObject) {
        if let source = source as? ActionCellCellSource {
            actionTitle.text = source.title
        }
    }
}
