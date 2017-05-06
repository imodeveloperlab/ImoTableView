//
//  TestACell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class TestACell: ImoTableViewCell {
    open override func setUpWithSource(source: AnyObject) {
        if let source = source as? TestACellSource {
            print(source)
        }
    }
}

open class TestACellSource: ImoTableViewSource {
    
    public init() {
        
        super.init(cellClass: "TestACell")
        setNibBundle(with:Bundle.init(for: self.classForCoder))
        self.height = 100
    }
}
