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
enum ImoTableViewSectionError: Error {
    case unknown
    case dontExistSourceAtIndex
    case dontExistSectionAtIndex
}

/// Section hold all table sources, header and footer view
open class ImoTableViewSection: NSObject {
    
    /// default is 40
    public var estimatedHeaderHeight: CGFloat = 40
    /// default is 40
    public var estimatedFooterHeight: CGFloat = 40
    /// Manual header height, if is nill table will use estimatedHeaderHeight
    public var headerHeight: CGFloat?
    /// Manual footer height, if is nill table will use estimatedFooterHeight
    public var footerHeight: CGFloat?
    /// Header UIView
    public var headerView: UIView?
    /// Footer UIView
    public var footerView: UIView?
    /// Header title
    public var headerTitle: String?
    /// Footer title
    public var footerTitle: String?
    /// Show header if section is empty
    public var showHeaderIfSectionIsEmpty: Bool = false
    
    /// For checking if section was change, means you have added or deleted some cell sources
    /// is set to true when some changes happen and to false when cells from this section are
    /// updated on screen
    public var wasChanged = false
    
    /// Section was changed
    public var didChange: ((ImoTableViewSection) -> (Void))?
    
    /// Sourcess array
    var sources = [ImoTableViewSource]()
    
    public override init() {
    }
    
    // MARK: -
    // MARK: Get
    
    /// Get source from section specific index
    ///
    /// - Parameter index: Source Index
    /// - Returns: ImoTableViewSource?
    public func get(sourceAtIndex index: Int) -> ImoTableViewSource? {
        
        if containIndex(index: index) {
            return sources[index]
        }
        return nil
    }
    
    // MARK: -
    // MARK: Delete
    
    /// Delete source from section
    ///
    /// - Parameter source: Source you want to delete
    /// - Throws: ImoTableViewSectionError
    public func delete(_ source: ImoTableViewSource) throws {
        
        wasChanged = true
        sectionWasChanged()
        sources.remove(at: try indexOfSource(source: source))
    }
    
    /// Delete if source exist using Equtable protocol
    ///
    /// - Parameter source: CellSource
    public func deleteIfExist(source: ImoTableViewSource) {
        
        if sources.contains(source) {
            
            wasChanged = true
            sectionWasChanged()
            
            do {
                sources.remove(at: try indexOfSource(source: source))
            } catch {
                print(error)
            }
        }
    }
    
    /// Delete source from section specific index
    ///
    /// - Parameter index: Source Index
    /// - Throws: ImoTableViewSectionError
    public func delete(atIndex index: Int) throws {
        
        wasChanged = true
        sectionWasChanged()
        
        if containIndex(index: index) {
            sources.remove(at: index)
        } else {
            throw ImoTableViewSectionError.unknown
        }
    }
    
    /// Delete sources from section
    ///
    /// - Parameter source: Source you want to delete
    /// - Throws: ImoTableViewSectionError
    public func delete(sources: [ImoTableViewSource]) throws {
        
        wasChanged = true
        sectionWasChanged()
        
        for source in sources {
            self.sources.remove(at: try indexOfSource(source: source))
        }
    }
    
    /// Delete all sources
    public func deleteAll() {
        
        wasChanged = true
        sectionWasChanged()
        sources.removeAll()
    }
    
    // MARK: -
    // MARK: ADD
    
    /// Add new source in section
    ///
    /// - Parameter source: CellSource
    public func add(_ source: ImoTableViewSource,
                    target: AnyObject? = nil,
                    _ selector: Selector? = nil) {
        
        wasChanged = true
        sectionWasChanged()
        
        if let target = target {
            source.target = target
        }
        
        if let selector = selector {
            source.selector = selector
        }
        
        sources.append(source)
    }
    
    /// Add new source at begin of section
    ///
    /// - Parameter source: CellSource
    public func addOnTop(_ source: ImoTableViewSource,
                         target: AnyObject? = nil,
                         _ selector: Selector? = nil) {
        
        wasChanged = true
        sectionWasChanged()
        
        if let target = target {
            source.target = target
        }
        
        if let selector = selector {
            source.selector = selector
        }
        
        sources.insert(source, at: 0)
    }
    
    /// Add array of sources on top
    ///
    /// - Parameters:
    ///   - sources: Cell Source
    ///   - target: Add source action to an target
    ///   - selector: Sellector for target
    public func addOnTop(sources: [ImoTableViewSource],
                         target: AnyObject? = nil,
                         _ selector: Selector? = nil) {
        
        wasChanged = true
        sectionWasChanged()
        
        for source in sources {
            self.addOnTop(source, target: target, selector)
        }
    }
    
    /// Add array of sources
    ///
    /// - Parameters:
    ///   - sources: Cell Source
    ///   - target: Add source action to an target
    ///   - selector: Sellector for target
    public func add(sources: [ImoTableViewSource],
                    target: AnyObject? = nil,
                    _ selector: Selector? = nil) {
        
        wasChanged = true
        sectionWasChanged()
        
        for source in sources {
            self.add(source, target: target, selector)
        }
    }
    
    /// Add new source in section if source not exist using Equtable protocol
    ///
    /// - Parameter source: CellSource
    public func addIfNotExist(source: ImoTableViewSource) {
        
        for compareSource in sources where compareSource == source {
            return
        }
        
        wasChanged = true
        sources.append(source)
        sectionWasChanged()
    }
    
    // MARK: -
    // MARK: HELPERS
    
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
    
    /// All sources
    ///
    /// - Returns: [CellSource]
    public func allSources() -> [ImoTableViewSource] {
        return sources
    }
    
    /// Get index for given source
    ///
    /// - Parameter source: CellSource
    /// - Returns: Index
    /// - Throws: ImoTableViewSectionError
    public func indexOfSource(source: ImoTableViewSource) throws -> Int {
        
        if let index = sources.index(of: source) {
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
    
    /// Check if section contain given index
    ///
    /// - Parameter index: Index
    /// - Returns: Bool
    public func containIndex(index: Int) -> Bool {
        
        if sources.indices.contains(index) {
            return true
        }
        return false
    }
    
    /// This func is called when in section was made a change
    func sectionWasChanged() {
        weak var weakSelf = self
        if let ws = weakSelf {
            if let closure = didChange {
                closure(ws)
            }
        }
    }
}
