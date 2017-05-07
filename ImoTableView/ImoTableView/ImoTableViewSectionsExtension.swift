//
//  ImoTableViewSourcesExtension.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 5/7/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import UIKit

public extension ImoTableView {
    
    /// Add section
    ///
    /// - Parameters:
    ///   - section: Section
    ///   - animated: Animated or not
    ///   - animation: Animation type
    public func add(section: ImoTableViewSection,
                    animated: Bool = false,
                    animation: UITableViewRowAnimation = .fade) {
        
        sections.append(section)
        
        if animated {
            animateInsertSection(section, animation)
        }
    }
    
    /// Add sections
    ///
    /// - Parameters:
    ///   - sections: Array of sections
    ///   - animated: Animated or not
    ///   - animation: Animation type
    public func add(sections: [ImoTableViewSection],
                    animated: Bool = false,
                    animation: UITableViewRowAnimation = .fade) {
        
        self.sections.append(contentsOf: sections)
        if animated {
            animateInsertSections(sections, animation)
        }
    }
    
    /// Delete section at index
    ///
    /// - Parameters:
    ///   - index: Section index
    ///   - animated: Animated or not
    ///   - animation: Animation type
    public func deleteSection(at index: Int,
                              animated: Bool = false,
                              animation: UITableViewRowAnimation = .fade) {
        
        if self.sections.indices.contains(index) {
            self.sections.remove(at: index)
            
            if animated {
                animateDeleteSections([index])
            }
        }
    }
    
    /// Delete section
    ///
    /// - Parameters:
    ///   - section: Section
    ///   - animated: Animate or not
    ///   - animation: Animation type
    public func delete(section: ImoTableViewSection,
                       animated: Bool = false,
                       animation: UITableViewRowAnimation = .fade) {
        
        self.delete(add(sections: [section], animated: animated, animation: animation))
    }
    
    /// Delete sections
    ///
    /// - Parameters:
    ///   - sections: Array of Sections
    ///   - animated: Animate or not
    ///   - animation: Animation type
    public func delete(sections: [ImoTableViewSection],
                       animated: Bool = false,
                       animation: UITableViewRowAnimation = .fade) {
        
        let indexSet = indexSetForSections(sections: sections)
        
        for sectionIndex in indexSet {
            self.sections.remove(at: sectionIndex)
        }
        
        if animated {
            animateDeleteSections(indexSet)
        }
    }
    
    /// Delete all sections
    ///
    /// - Parameters:
    ///   - animated: Animate or not
    ///   - animation: Animation type
    public func deleteAllSections(animated: Bool = false,
                                  animation: UITableViewRowAnimation = .fade) {
        
        let indexSet = indexSetForSections(sections: self.sections)
        
        sections.removeAll()
        
        if animated {
            animateDeleteSections(indexSet, animation)
        }
    }
    
    /// Delete first section from table
    ///
    /// - Parameters:
    ///   - animated: Animated or not
    ///   - animation: Animation type
    public func deleteFirstSection(animated: Bool = false,
                                   animation: UITableViewRowAnimation = .fade) {
        
        var indexSet: IndexSet = []
        
        if let section = self.firstSection() {
            indexSet = indexSetForSections(sections:[section])
        }
        
        sections.removeFirst()
        
        if animated {
            animateDeleteSections(indexSet)
        }
    }
    
    /// Delete last section
    ///
    /// - Parameters:
    ///   - animated: Animated or not
    ///   - animation: Animation type
    public func deleteLastSection(animated: Bool = false,
                                  animation: UITableViewRowAnimation = .fade) {
        
        var indexSet: IndexSet = []
        
        if let section = self.firstSection() {
            indexSet = indexSetForSections(sections:[section])
        }
        
        sections.removeLast()
        
        if animated {
            animateDeleteSections(indexSet)
        }
    }
    
    /// Get fist section
    ///
    /// - Returns: Section if exist
    public func firstSection() -> ImoTableViewSection? {
        return self.sections.first
    }
    
    /// Last section
    ///
    /// - Returns: Section if exist
    public func lastSection() -> ImoTableViewSection? {
        return self.sections.last
    }
    
    /// Get section for given Index
    ///
    /// - Parameter index: Section index
    /// - Returns: ImoTableViewSection?
    public func sectionForIndex(index: Int) -> ImoTableViewSection? {
        
        if self.sections.indices.contains(index) {
            return self.sections[index]
        }
        return nil
    }
    
    /// Get cell source for IndexPath
    ///
    /// - Parameter indexPath: IndexPath
    /// - Returns: ImoTableViewSource?
    public func cellSourceForIndexPath(indexPath: IndexPath) -> ImoTableViewSource? {
        
        if self.sections.indices.contains(indexPath.section) {
            let section : ImoTableViewSection = self.sections[indexPath.section]
            return section.get(sourceAtIndex: indexPath.row)
        }
        return nil
    }
    
    /// Index of section
    ///
    /// - Parameter section: Section object
    /// - Returns: Section Index
    public func indexFor(section: ImoTableViewSection) -> Int? {
        return self.sections.index(of:section)
    }
    
    // MARK: - Animated updates
    
    /// Animate insert section
    ///
    /// - Parameters:
    ///   - section: Section to insert
    ///   - animation: Animation type
    func animateInsertSection(_ section: ImoTableViewSection,
                              _ animation: UITableViewRowAnimation = .fade) {
        
        animateInsertSections([section], animation)
    }
    
    /// Animate insert sections
    ///
    /// - Parameters:
    ///   - sections: Array of sections
    ///   - animation: Animation type
    func animateInsertSections(_ sections: [ImoTableViewSection],
                               _ animation: UITableViewRowAnimation = .fade) {
        
        let sectionsIndexSet = indexSetForSections(sections: sections)
        let indicesSet = IndexSet(sectionsIndexSet)
        self.tableView.insertSections(indicesSet, with: animation)
    }
    
    /// Animate delete sections
    ///
    /// - Parameters:
    ///   - sections: IndexSet of sections
    ///   - animation: Animation type
    func animateDeleteSections(_ sections: IndexSet,
                               _ animation: UITableViewRowAnimation = .fade) {
        
        if sections.count > 0 {
            self.tableView.deleteSections(sections, with: animation)
        }
    }
    
    /// Index set for sections
    ///
    /// - Parameter sections: Array of sections
    /// - Returns: IndexSet
    func indexSetForSections(sections: [ImoTableViewSection]) -> IndexSet {
        
        var indexes: [Int] = []
        for section in sections {
            if let sectionIndex = self.sections.index(of: section) {
                indexes.append(sectionIndex)
            }
        }
        return IndexSet(indexes)
    }
}
