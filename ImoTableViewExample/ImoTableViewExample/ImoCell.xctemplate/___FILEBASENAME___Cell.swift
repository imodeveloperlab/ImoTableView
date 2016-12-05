//
//  ___FILEBASENAME___Cell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class ___FILEBASENAME___CellSource : ImoTableViewSource {
    
    public init() {
        
        //TODO: Do your work here
        super.init(cellClass: "___FILEBASENAME___Cell")
        self.setUp()
    }
    
    public init(staticCellWithTableView tableView:ImoTableView) {
        
        super.init(cellClass: "___FILEBASENAME___Cell")
        self.setUp()
        
        tableView.registerCellClass(cellClass: "___FILEBASENAME___Cell", nib: self.nib)
        self.staticCell = tableView.dequeueReusableCell(withIdentifier:"___FILEBASENAME___Cell") as! ImoTableViewCell?
    }
    
    func setUp() {
        
        //Load the nib file
        self.nib = UINib(nibName: self.cellClass, bundle: Bundle.init(for: self.classForCoder))
        
        //Height and width have default value but you can change it here or dynamically from extern
        self.height = 100
    }
    
}

open class ___FILEBASENAME___Cell : ImoTableViewCell {
    
    open override func setUpWithSource(source:AnyObject) {
        
        if source is ___FILEBASENAME___CellSource {
            
            //TODO: Do your work here
            
        }
    }
}
