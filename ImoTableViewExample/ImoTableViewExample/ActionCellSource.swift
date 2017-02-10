//
//  ActionCell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class ActionCellSource : ImoTableViewSource {
    
    public var title : String

    init(title:String) {
        self.title = title
        //Init source an specify cell class you will represent by this source
        super.init(cellClass: "ActionCell")
        //Set nib bundle if your cell is not in current project bundle
        setNibBundle(with:Bundle.init(for: self.classForCoder))
        
        self.height = 70
    }
}
