//
//  ExampleCell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class ExampleCellSource : ImoTableViewSource {
    
    public init() {
        
        //TODO: Do your work here
        
        super.init(cellClass: "ExampleCell")
        
        //Load the nib file
        self.nib = UINib(nibName: self.cellClass, bundle: Bundle.init(for: self.classForCoder))
        
        //Height and width have default value but you can change it here or dynamically from extern
        self.height = 100
        
    }
    
}

open class ExampleCell : ImoTableViewCell {
    
    open override func setUpWithSource(source:AnyObject) {
        
        if source is ExampleCellSource {
            
            //TODO: Do your work here
            
        }
    }
}
