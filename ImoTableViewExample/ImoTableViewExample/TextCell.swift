//
//  TextCellCell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class TextCell: ImoTableViewCell {
    
    @IBOutlet weak var label: UILabel!
    open override func setUpWithSource(source: AnyObject) {
        if let source = source as? TextCellSource {
            label.text = source.text
        }
    }
}

open class TextCellSource: ImoTableViewSource {
    
    var text: String
    public init(text: String) {
        self.text = text
        super.init(cellClass: "TextCell")
        setNibBundle(with:Bundle.init(for: self.classForCoder))
    }
}
