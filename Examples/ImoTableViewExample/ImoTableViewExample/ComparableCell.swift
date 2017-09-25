//
//  ComparableCell.swift
//  ImoTableViewTemplates
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import ImoTableView
import UIKit

open class ComparableCell: ImoTableViewCell {
    
    @IBOutlet weak var message: UILabel!
    
    open override func setUpWithSource(source: AnyObject) {
        if let source = source as? ComparableCellSource {
            self.message.text = source.message
        }
    }
}

open class ComparableCellSource: ImoTableViewSource {
    
    public let message: String
    
    public init(message: String) {
        
        self.message = message
        super.init(cellClass: "ComparableCell")
        setNibBundle(with:Bundle.init(for: self.classForCoder))
        self.height = 100
    }
    
    
    
    
    static func == (lhs: ComparableCellSource, rhs: ComparableCellSource) -> Bool {
        return lhs.message == rhs.message
    }
}

extension ComparableCellSource {
    
    override open func isEqual(_ source: Any?) -> Bool {
        return message == (source as! ComparableCellSource).message
    }
    
}
