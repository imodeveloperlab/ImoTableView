//
//  ImoTableViewSources.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 5/7/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import UIKit

public extension ImoTableView {
    
    /// Add source in section
    ///
    /// - Parameters:
    ///   - source: CellSource
    ///   - section: Section
    ///   - animated: Animated update
    ///   - animation: Animation type
    func add(source: ImoTableViewSource,
             in section: ImoTableViewSection,
             animated: Bool = false,
             animation: UITableViewRowAnimation = .fade) {
        
        add(sources: [source],
            in: section,
            animated: animated,
            animation: animation)
    }
    
    /// Add array of sources in section
    ///
    /// - Parameters:
    ///   - sources: CellSource
    ///   - section: Section
    ///   - animated: Animated update
    ///   - animation: Animation type
    func add(sources: [ImoTableViewSource],
             in section: ImoTableViewSection,
             animated: Bool = false,
             animation: UITableViewRowAnimation = .fade) {
        
        section.add(sources: sources)
        
        if animated {
            tableView.insertRows(at: indexPathsForSources(sources: sources, in: section),
                                 with: animation)
        }
    }
    
    /// Delete source from section
    ///
    /// - Parameters:
    ///   - source: Source to delete
    ///   - section: Section
    ///   - animated: Animated update
    ///   - animation: Animation type
    func delete(source: ImoTableViewSource,
                in section: ImoTableViewSection,
                animated: Bool = false,
                animation: UITableViewRowAnimation = .fade) {
        
        delete(sources: [source],
               in: section,
               animated: animated,
               animation: animation)
    }
    
    /// Delete array of sources from section
    ///
    /// - Parameters:
    ///   - sources: Sources to delete
    ///   - section: Section
    ///   - animated: Animated update
    ///   - animation: Animation type
    func delete(sources: [ImoTableViewSource],
                in section: ImoTableViewSection,
                animated: Bool = false,
                animation: UITableViewRowAnimation = .fade) {
        
        let indexPathArray = indexPathsForSources(sources: sources, in: section)
        
        do {
            try section.delete(sources: sources)
        } catch { print(error) }
        
        if animated {
            tableView.deleteRows(at: indexPathArray,
                                 with: animation)
        }
    }
    
    /// Update source
    ///
    /// - Parameters:
    ///   - source: Source to update
    ///   - section: Section
    ///   - animated: Animated update
    ///   - animation: Animation type
    func update(source: ImoTableViewSource,
                in section: ImoTableViewSection,
                animated: Bool = false,
                animation: UITableViewRowAnimation = .fade) {
        
        update(sources: [source], in: section,
               animated: animated,
               animation: animation)
    }
    
    /// Update array of sources
    ///
    /// - Parameters:
    ///   - sources: Sources to update
    ///   - section: Section
    ///   - animated: Animated update
    ///   - animation: Animation type
    func update(sources: [ImoTableViewSource],
                in section: ImoTableViewSection,
                animated: Bool = false,
                animation: UITableViewRowAnimation = .fade) {
        
        let indexPaths = indexPathsForSources(sources: sources, in: section)
        
        if animated {
            tableView.reloadRows(at: indexPaths, with: animation)
        }
    }
    
    /// Array of indexPaths for sources in section
    ///
    /// - Parameters:
    ///   - sources: Array of sources
    ///   - section: Section
    /// - Returns: Array of IndexPath
    func indexPathsForSources(sources: [ImoTableViewSource],
                              in section: ImoTableViewSection) -> [IndexPath] {
        
        var indexes: [IndexPath] = []
        if let sectionIndex = self.indexFor(section: section) {
            for source in sources {
                do {
                    let sourceIndex = try section.indexOfSource(source: source)
                    indexes.append(IndexPath(row: sourceIndex, section: sectionIndex))
                } catch { print(error) }
            }
        }
        
        return indexes
    }
}