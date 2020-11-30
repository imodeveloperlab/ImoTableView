//
//  ImoTableViewActions.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import UIKit

public extension ImoTableView {
    
    /// Did select row delegate
    ///
    /// - Parameters:
    /// - tableView: UITableView
    /// - indexPath: IndexPath
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        if let source = self.cellSourceForIndexPath(indexPath: indexPath) {
            
            didSelect(source: source)
            didSelectCellAtIndexPath(indexPath: indexPath)
            performSelector(for: source)
        }
    }
    
    /// Will call didSelectSource clossure if didSelectSource is not nill
    ///
    /// - Parameter source: CellSource
    func didSelect(source: ImoTableViewSource) {
        
        if let didSelect = self.didSelectSource {
            DispatchQueue.main.async {
                didSelect(source)
            }
        }
    }
    
    /// Will call didSelectCellAtIndexPath clossure if didSelectCellAtIndexPath is not nill
    ///
    /// - Parameter indexPath: IndexPath
    func didSelectCellAtIndexPath(indexPath: IndexPath) {
        
        if let action = self.didSelectCellAtIndexPath {
            action(indexPath)
        }
    }
    
    /// Perform selector
    ///
    /// - Parameter source: ImoTableViewSource
    func performSelector(for source: ImoTableViewSource) {
        
        if let target = source.target {
            if let selector = source.selector {
                performSelector(target: target, selector: selector, source: source)
            }
        }
    }
    
    /// Perform selector
    ///
    /// - Parameters:
    ///   - target: Target
    ///   - selector: Selector
    ///   - source: CellSource
    func performSelector(target: AnyObject,
                         selector: Selector,
                         source: ImoTableViewSource) {
        
        DispatchQueue.main.async {
            
            if target.responds(to: selector) {
                if let object = source.object {
                    _ = target.perform(selector, with: object)
                } else {
                    _ = target.perform(selector, with: source)
                }
            }
        }
    }
}
