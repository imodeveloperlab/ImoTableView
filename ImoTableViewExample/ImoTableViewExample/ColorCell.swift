//
//  ColorCell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class ColorCell: ImoTableViewCell {
    open override func setUpWithSource(source: AnyObject) {
        if let source = source as? ColorCellSource {
        }
    }
}

open class ColorCellSource: ImoTableViewSource {
    
    public init() {
        super.init(cellClass: "ColorCell")
        setNibBundle(with:Bundle.init(for: self.classForCoder))
    }
}
