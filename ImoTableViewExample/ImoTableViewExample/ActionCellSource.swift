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

    init(title: String) {
        self.title = title
        super.init(cellClass: "ActionCell")
        setNibBundle(with:Bundle.init(for: self.classForCoder))
    }
}
