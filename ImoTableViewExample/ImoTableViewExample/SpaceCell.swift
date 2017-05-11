//
//  SpaceCell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class SpaceCell: ImoTableViewCell {
    open override func setUpWithSource(source: AnyObject) {
        if let source = source as? SpaceCellSource {
        }
    }
}

open class SpaceCellSource: ImoTableViewSource {
    
    public init() {
        super.init(cellClass: "SpaceCell")
        setNibBundle(with:Bundle.init(for: self.classForCoder))
        self.height = 50
    }
}
