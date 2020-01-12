//
//  ImoTableViewSources.swift
//  ImoTableView
//
//  Created by Winify AG on 5/7/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import UIKit

public extension ImoTableView {
    
    /// Add source on top in section
    ///
    /// - Parameters:
    ///   - source: CellSource
    ///   - section: Section
    ///   - animated: Animated update
    ///   - animation: Animation type
    func addOnTop(source: ImoTableViewSource,
                  in section: ImoTableViewSection,
                  animated: Bool = false,
                  animation: UITableView.RowAnimation = .fade) {
        
        addOnTop(sources: [source],
                 in: section,
                 animated: animated,
                 animation: animation)
    }
    
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
             animation: UITableView.RowAnimation = .fade) {
        
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
             animation: UITableView.RowAnimation = .fade) {
        
        section.add(sources: sources)
        
        if animated {
            tableView.insertRows(at: indexPathsForSources(sources: sources, in: section),
                                 with: animation)
        }
    }
    
    /// Add array of sources on top in section
    ///
    /// - Parameters:
    ///   - sources: CellSource
    ///   - section: Section
    ///   - animated: Animated update
    ///   - animation: Animation type
    func addOnTop(sources: [ImoTableViewSource],
                  in section: ImoTableViewSection,
                  animated: Bool = false,
                  animation: UITableView.RowAnimation = .fade) {
        
        section.addOnTop(sources: sources)
        
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
                animation: UITableView.RowAnimation = .fade) {
        
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
                animation: UITableView.RowAnimation = .fade) {
        
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
                animation: UITableView.RowAnimation = .fade) {
        
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
                animation: UITableView.RowAnimation = .fade) {
        
        let indexPaths = indexPathsForSources(sources: sources, in: section)
        
        if animated {
            tableView.reloadRows(at: indexPaths, with: animation)
        } else {
            self.update()
        }
    }
    
    func update(section: ImoTableViewSection, animated: Bool = false,
                animation: UITableView.RowAnimation = .fade) {
        
        if let index = indexSetFor(section: section) {
            if animated {
                tableView.reloadSections([index], with: animation)
            } else {
                self.update()
            }
        }
    }
    
    func update(sections: [ImoTableViewSection], animated: Bool = false,
                animation: UITableView.RowAnimation = .fade) {
        
        if let indexArray = indexSetFor(sections: sections) {
            if animated {
                tableView.reloadSections(indexArray, with: animation)
            } else {
                self.update()
            }
        }
    }
    
    func updateChangedSections(animation: UITableView.RowAnimation = .fade) {
        
        if let indexArray = indexSetForChanged(sections: sections) {
            tableView.reloadSections(indexArray, with: animation)
        }
    }
    
    func getSectionFor(source: ImoTableViewSource) -> ImoTableViewSection? {
        
        for section in sections {
            for checkSource in section.sources where checkSource == source {
                return section
            }
        }
        
        return nil
    }
    
    func indexPathsFor(source: ImoTableViewSource) -> IndexPath? {
        
        if let section = getSectionFor(source: source) {
            let indexPaths = indexPathsForSources(sources: [source], in: section)
            if let indexPath = indexPaths.first {
                return indexPath
            }
        }
        
        return nil
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
        if let sectionIndex = self.indexSetFor(section: section) {
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
