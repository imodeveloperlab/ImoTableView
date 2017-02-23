//
//  ___FILEBASENAME___Cell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class ___FILEBASENAME___Cell: ImoTableViewCell {
    open override func setUpWithSource(source: AnyObject) {
        if let source = source as? ___FILEBASENAME___CellSource {
            //TODO: Do your work here
            print(source)
        }
    }
}

open class ___FILEBASENAME___CellSource: ImoTableViewSource {
    
    public init() {
        
        //TODO: Set your properties here
        super.init(cellClass: "___FILEBASENAME___Cell")
        //Set nib bundle if your cell is not in current project bundle
        setNibBundle(with:Bundle.init(for: self.classForCoder))
        //Height and width have default value but you can change it here or dynamically from extern
        self.height = 100
    }
}
