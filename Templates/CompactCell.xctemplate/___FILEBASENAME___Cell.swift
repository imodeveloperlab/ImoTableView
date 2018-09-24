//
//  ___FILEBASENAME___.swift
//  ImoTableViewTemplates
//
//  Created by Winify AG on 12/5/16.
//  Copyright © 2016 Winify AG. All rights reserved.
//

import ImoTableView
import UIKit

open class ___FILEBASENAME___: ImoTableViewCell {
    open override func setUpWithSource(source: AnyObject) {
        if let source = source as? ___FILEBASENAME___Source {
            //TODO: Do your work here
            print(source)
        }
    }
}

open class ___FILEBASENAME___Source: ImoTableViewSource {

    public init() {

        //TODO: Set your properties here
        super.init(cellClass: "___FILEBASENAME___")
        //Set nib bundle if your cell is not in current project bundle
        setNibBundle(with: Bundle.init(for: self.classForCoder))
        //Height and width have default value but you can change it here or dynamically from extern
        self.height = 100
    }
}
