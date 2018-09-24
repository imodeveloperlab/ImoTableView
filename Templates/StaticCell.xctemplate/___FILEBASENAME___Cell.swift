//
//  ___FILEBASENAME___.swift
//  ImoTableViewTemplates
//
//  Created by Winify AG on 12/5/16.
//  Copyright © 2016 Winify AG. All rights reserved.
//

import ImoTableView
import UIKit

open class ___FILEBASENAME___Source: ImoTableViewSource {
    
    var appearance: MMDesignable?
    
    public init(static table: ImoTableView, _ appearance: MMDesignable) {
        
        self.appearance = appearance
        super.init(cellClass: "___FILEBASENAME___")
        setNibBundle(with: Bundle.init(for: self.classForCoder))
        staticCell = table.statiCell(cellClass: "___FILEBASENAME___", nib: self.nib)
        self.height = 100
    }
    
    // swiftlint:disable force_cast
    public var cell: ___FILEBASENAME___ {
        return self.staticCell as! ___FILEBASENAME___
    }
}

open class ___FILEBASENAME___: ImoTableViewCell {

    open override func setUpWithSource(source: AnyObject) {

        if source is ___FILEBASENAME___Source {
            //TODO: Do your work here
        }
    }
}
