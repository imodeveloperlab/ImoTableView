//
//  DemoCell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class DemoCellSource : ImoTableViewSource {
    
    public init() {
        
        //TODO: Do your work here
        super.init(cellClass: "DemoCell")
        self.setUp()
    }
    
    public init(staticCellWithTableView tableView:ImoTableView) {
        
        super.init(cellClass: "DemoCell")
        self.setUp()
        
        tableView.registerCellClass(cellClass: "DemoCell", nib: self.nib)
        self.staticCell = tableView.dequeueReusableCell(withIdentifier:"DemoCell") as! ImoTableViewCell?
    }
    
    func setUp() {
        
        //Load the nib file
        self.nib = UINib(nibName: self.cellClass, bundle: Bundle.init(for: self.classForCoder))
        
        //Height and width have default value but you can change it here or dynamically from extern
       // self.height = 50
    }
    
}

open class DemoCell : ImoTableViewCell {
    
    open override func setUpWithSource(source:AnyObject) {
        
        if source is DemoCellSource {
            
            //TODO: Do your work here
            
        }
    }
}
