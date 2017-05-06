//
//  TestCell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class TestCell: ImoTableViewCell {
    open override func setUpWithSource(source: AnyObject) {
        if let source = source as? TestCellSource {
            print(source)
        }
    }
}

open class TestCellSource: ImoTableViewSource {
    
    public init() {
        super.init(cellClass: "TestCell")
        setNibBundle(with:Bundle.init(for: self.classForCoder))
        self.height = 100
    }
}
