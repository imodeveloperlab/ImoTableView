//
//  TextFieldCell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class TextFieldCellSource: ImoTableViewSource {
    
    public init() {

        super.init(cellClass: "TextFieldCell")
        self.setUp()
    }
    
    public init(staticCellWithTableView tableView: ImoTableView) {
        
        super.init(cellClass: "TextFieldCell")
        self.setUp()
        
        tableView.registerCellClass(cellClass: "TextFieldCell", nib: self.nib)
        self.staticCell = tableView.view.dequeueReusableCell(withIdentifier:"TextFieldCell") as! ImoTableViewCell?
    }
    
    func setUp() {
        setNibBundle(with: Bundle.init(for: self.classForCoder))
    }
}

open class TextFieldCell: ImoTableViewCell {
    
    open override func setUpWithSource(source: AnyObject) {
        
        if source is TextFieldCellSource {
            
        }
    }
}
