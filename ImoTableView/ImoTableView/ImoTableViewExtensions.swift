//
//  ImoTableViewExtensions.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 2/21/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import Foundation

public struct ImoTableSource {
   
    var cellClass : String
    
    public init(cellClass : String) {
        self.cellClass = cellClass
    }
    
}

public struct ImoTableSection {
    
    public init () {
        
    }
    
    public var ion : String = ""
    
    var sources : [ImoTableSource] = []
}

public extension ImoTableSection {
    
    mutating func addSource(source:ImoTableSource) {
        sources.append(source)
    }
}
