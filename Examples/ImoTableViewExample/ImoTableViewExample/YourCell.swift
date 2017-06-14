//
//  YourCell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class YourCell: ImoTableViewCell {
    open override func setUpWithSource(source: AnyObject) {
        if let source = source as? YourCellSource {
            //TODO: Do your work here
            print(source)
        }
    }
}
