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
    case dontExistSectionAtIndex
}

/// Section hold all table sources, header and footer view
open class ImoTableViewSection : NSObject {
    
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
    /// Header title
    public var headerTitle : String?
    /// Footer title
    public var footerTitle : String?
    /// Sourcess array
    var sources = [ImoTableViewSource]()
    
    public override init() {
        
    }
    
    /// Add new source in section
    ///
    /// - Parameter source: CellSource
    public func add(_ source: ImoTableViewSource, target:AnyObject? = nil, _ selector:Selector? = nil) {
        
        if let target = target {
            source.target = target
        }
        
        if let selector = selector {
            source.selector = selector
        }
        
        sources.append(source)
    }
    
    /// Add array of sources
    ///
    /// - Parameters:
    ///   - sources: Cell Source
    ///   - target: Add source action to an target
    ///   - selector: Sellector for target
    public func add(sources: [ImoTableViewSource], target:AnyObject? = nil, _ selector:Selector? = nil) {
        for source in sources {
            self.add(source, target: target, selector)
        }
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
    public func delete(_ source: ImoTableViewSource) throws {
        
        sources.remove(at:try indexOfSource(source:source))
    }
    
    /// Delete sources from section
    ///
    /// - Parameter source: Source you want to delete
    /// - Throws: ImoTableViewSectionError
    public func delete(sources: [ImoTableViewSource]) throws {
        
        for source in sources {
            self.sources.remove(at: try indexOfSource(source: source))
        }
    }
    
    /// Delete all sources
    public func deleteAll() {
        sources.removeAll()
    }
    
    /// Last source if exist
    ///
    /// - Returns: CellSource
    public func lastSource() -> ImoTableViewSource? {
       return sources.last
    }
    
    /// FirstSource if exist
    ///
    /// - Returns: CellSource
    public func firstSource() -> ImoTableViewSource? {
        return sources.first
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
    
    /// Sources count
    ///
    /// - Returns: Sources count
    public func count() -> Int {
        return sources.count
    }
}
