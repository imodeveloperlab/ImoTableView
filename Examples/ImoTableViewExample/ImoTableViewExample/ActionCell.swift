//
//  ActionCell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class ActionCell : ImoTableViewCell {

    //UILabel from ActionCell.xib
    @IBOutlet weak var actionTitle: UILabel!
    //This method is called every time your cell will be displayed on screen
    open override func setUpWithSource(source:AnyObject) {
        //Cast source to ActionCellSource
        if let source = source as? ActionCellSource {
            //Set the label title
            self.actionTitle.text = source.title
        }
    }
}
