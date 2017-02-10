//
//  ImoTableViewSection.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import UIKit

/// ImoTableViewSection Errors
///
/// - unknown: Uknown Error
/// - dontExistSourceAtIndex: Missing source for given index
enum ImoTableViewSectionError : Error {
    case unknown
    case dontExistSourceAtIndex
}

/// Section hold all table sources, header and footer view
open class ImoTableViewSection {
    
    /// default is 40
    public var estimatedHeaderHeight : CGFloat = 40
    /// default is 40
    public var estimatedFooterHeight : CGFloat = 40
    /// Manual header height, if is nill table will use estimatedHeaderHeight
    public var headerHeight : CGFloat?
    /// Manual footer height, if is nill table will use estimatedFooterHeight
    public var footerHeight : CGFloat?
    /// Header UIView
    public var headerView : UIView?
    /// Footer UIView
    public var footerView : UIView?
    
    var sources = [ImoTableViewSource]()
    
    public init() {
        
    }
    
    /// Add new source in section
    ///
    /// - Parameter source: CellSource
    public func add(_ source: ImoTableViewSource) {
        sources.append(source)
    }
    
    /// Get source from section specific index
    ///
    /// - Parameter index: Source Index
    /// - Returns: ImoTableViewSource?
    public func get(sourceAtIndex index:Int) -> ImoTableViewSource? {
        if containIndex(index:index) {
            return sources[index]
        }
        return nil
    }
    
    /// Delete source from section specific index
    ///
    /// - Parameter index: Source Index
    /// - Throws: ImoTableViewSectionError
    public func delete(atIndex index:Int) throws {
        
        if containIndex(index:index) {
           sources.remove(at: index)
        } else {
            throw ImoTableViewSectionError.unknown
        }
    }
    
    /// Check if section contain given index
    ///
    /// - Parameter index: Index
    /// - Returns: Bool
    public func containIndex(index:Int) -> Bool {
        
        if sources.indices.contains(index) {
            return true
        }
        return false
    }
    
    /// Delete source from section
    ///
    /// - Parameter source: Source you want to delete
    /// - Throws: ImoTableViewSectionError
    public func delete(_ source:ImoTableViewSource) throws {
        
        sources.remove(at:try indexOfSource(source:source))
    }
    
    /// Delete all sources
    public func deleteAll() {
        
        sources.removeAll()
    }
    
    /// Get index for given source
    ///
    /// - Parameter source: CellSource
    /// - Returns: Index
    /// - Throws: ImoTableViewSectionError
    public func indexOfSource(source:ImoTableViewSource) throws -> Int {

        if let index = sources.index(of:source) {
            return index
        } else {
            throw ImoTableViewSectionError.dontExistSourceAtIndex
        }
    }
    
    public func count() -> Int {
        return sources.count
    }
}
