//
//  ImoTableViewSection.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//


enum ImoTableViewSectionError : Error {
    case unknown
    case indexOfSource
}

open class ImoTableViewSection {
    
   public init() {
    
    
    }
    
    var sources = Array<ImoTableViewSource>()
    
    public func add(_ source:ImoTableViewSource) {
        
        sources.append(source)
    }
    
    public func get(sourceAtIndex index:Int) -> ImoTableViewSource? {
        
        if containIndex(index:index) {
            return sources[index]
        }
        
        return nil
    }
    
    public func delete(atIndex index:Int) throws {
        
        if containIndex(index:index) {
           sources.remove(at: index)
        }
        else {
            throw ImoTableViewSectionError.unknown
        }
    }
    
    public func containIndex(index:Int) -> Bool {
        
        if sources.indices.contains(index) {
            return true
        }
        return false;
    }
    
    public func delete(source:ImoTableViewSource) throws {
    
        sources.remove(at:try indexOfSource(source:source))
    }
    
    public func indexOfSource(source:ImoTableViewSource) throws -> Int {
        
        if let index = sources.index(of:source) {
            return index
        }
        else {
            
            throw ImoTableViewSectionError.indexOfSource
        }
    }
    
    public func count() -> Int {
        return sources.count
    }
    
}
