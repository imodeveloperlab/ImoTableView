//
//  ImoTableViewCell.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import UIKit

///ImoTableViewCell
open class ImoTableViewCell : UITableViewCell {
    
    /// This function is called every time cell will be displayed on screen
    ///
    /// - Parameter source: source:AnyObject
    open func setUpWithSource(source: AnyObject) {

    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        #if targetEnvironment(simulator)
        if let info = Bundle(identifier: "Winify-AG.Modules")?.infoDictionary {
            if let value = info["DEBUG_CELL_NAMES"] as? Bool {
                if value == true {
                    let label = UILabel()
                    label.text = String(describing: self)
                    label.backgroundColor = .blue
                    label.textColor = .white
                    label.font = UIFont.systemFont(ofSize: 8)
                    label.sizeToFit()
                    self.addSubview(label)
                }
            }
        }
        #endif
    }
}
