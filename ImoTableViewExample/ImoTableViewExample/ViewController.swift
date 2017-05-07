//
//  ViewController.swift
//  ImoTableViewExample
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import UIKit
import ImoTableView

class ViewController: UIViewController {

    var tableView : ImoTableView?
    let section = ImoTableViewSection()
    let addRowCellSource = ActionCellSource(title: "Add row in section")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Create an table andd ad on self.view
        tableView = ImoTableView(on: self.view, insets: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))

        if let tableView = self.tableView {
            
            //Add one section
            let addSectionCellSource = ActionCellSource(title: "Add section")
            section.add(addSectionCellSource, target:self, #selector(addSection))
            
            //Add one section
            let addSourceCellSource = ActionCellSource(title: "Add source")
            section.add(addSourceCellSource, target:self, #selector(addSource))
            
            //Add multiple sections
            let addSectionsCellSource = ActionCellSource(title: "Add multiple sections")
            section.add(addSectionsCellSource, target:self, #selector(addSections))

            //Delete last section
            let deleteSectionCellSource = ActionCellSource(title: "Delete last section")
            section.add(deleteSectionCellSource, target:self, #selector(deleteLastSection))
            
            //Delete last section
            let deleteSectionAtIndexCellSource = ActionCellSource(title: "Delete section at index")
            section.add(deleteSectionAtIndexCellSource, target:self, #selector(deleteLastSection))
            
            
            //Delete all sections
            let deleteAllSectionsCellSource = ActionCellSource(title: "Delete all sections")
            section.add(deleteAllSectionsCellSource, target:self, #selector(deleteAllSections))
            
            //Delete last source from last section
            let deleteLastSourceCellSource = ActionCellSource(title: "Delete last source from last section")
            section.add(deleteLastSourceCellSource, target:self, #selector(deleteLastCellSource))
            
            
            let updateFirtsCellSource = ActionCellSource(title: "Update first source")
            section.add(updateFirtsCellSource, target:self, #selector(updateFirstSource))
            
//
//            //Mix updates
//            let mixUpdatesCellSource = ActionCellSource(title: "Mix updates")
//            section.add(mixUpdatesCellSource, target:self, #selector(mixedUpdates))
//            
//            //Mix updates
//            let updateCellSource = ActionCellSource(title: "Update last section")
//            section.add(updateCellSource, target:self, #selector(updateLastSection))
//            
//            
//            //Mix updates
//            section.add(addRowCellSource, target:self, #selector(addRowInSection))

            //Add section to table View
            tableView.add(section:section)
            
            tableView.update()
      
        }
    }
    
    func addRowInSection() {
        
        let rowCellSource = ActionCellSource(title: "New ro in main section")
        section.add(rowCellSource)
        addRowCellSource.title = "Hello world";
        tableView?.update()
    }
    
    func addSections() {
        
        if let tableView = self.tableView {
            
            var sections : [ImoTableViewSection] = []
            sections.append(makeSection(with: "First section"))
            sections.append(makeSection(with: "Second section"))
            tableView.add(sections:sections, animated: true, animation: .fade)
        }
    }
    
    func addSection() {
        if let tableView = self.tableView {
            tableView.add(section:makeSection(with: "Animated Section"), animated: true, animation: .top)
        }
    }
    
    
    func updateFirstSource() {
        if let tableView = self.tableView {
            
             if let section = tableView.lastSection() {
                if let source = section.firstSource() {
                    if source.isKind(of: ActionCellSource.classForCoder()) {
                        let source = source as! ActionCellSource
                        source.title = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
                        tableView.update(source: source, in: section, animated: true, animation: .fade)
                    }
                }
            }
        }
    }
    
    func addSource() {
        
        if let tableView = self.tableView {
            
            let cellSource = ActionCellSource(title: "Animated inser cell")
            let cellSource2 = ActionCellSource(title: "Animated inser cell2")
            
            if let section = tableView.lastSection() {
                
                tableView.add(sources: [cellSource, cellSource2],
                              in: section,
                              animated: true,
                              animation: .top)
            }
            
        }
    }
    
    func deleteLastSection() {
        
        if let tableView = self.tableView {
            if let lastSection = tableView.lastSection() {
                tableView.delete(sections: [lastSection], animated: true, animation: .fade)
            }
        }
    }
    
    
    func deleteAllSections() {
        
        if let tableView = self.tableView {
            tableView.deleteAllSections(animated: true, animation: .bottom)
        }
    }
    
    func deleteLastCellSource() {
        
        if let tableView = self.tableView {
            if let lastSection = tableView.lastSection() {
                if let source = lastSection.lastSource() {
                    tableView.delete(source: source, in: lastSection, animated: true)
                }
            }
        }
    }
    
    
    func deleteSectionAtIndex() {
        
        if let tableView = self.tableView {
            if let lastSection = tableView.lastSection() {
                if let index = tableView.indexFor(section: lastSection) {
                    tableView.deleteSection(at: index, animated: true, animation: .bottom)
                }
            }
        }
    }
    
    
    func mixedUpdates() {
        
        if let tableView = self.tableView {
            
            tableView.deleteLastSection()
            tableView.add(section:makeSection(with: "Updated section 1"))
            tableView.add(section:makeSection(with: "Updated section 2"))
            tableView.add(section:makeSection(with: "Updated section 3"))
            tableView.deleteLastSection()
            tableView.add(section:makeSection(with: "Updated section 4"))
            tableView.add(section:makeSection(with: "Updated section 5"))
            tableView.update()
        }
    }
    
    func updateLastSection() {
        if let tableView = self.tableView {
            if let section = tableView.lastSection() {
                section.add(ActionCellSource(title: "New source"))
                tableView.update()
            }
        }
    }
    
    func makeSection(with title:String) -> ImoTableViewSection {
        
        let section = ImoTableViewSection()
        section.headerTitle = title
        section.headerHeight = 40
        
        let fisrsCellSource = ActionCellSource(title: "First cell source")
        section.add(fisrsCellSource)
        
        let secondCellSource = ActionCellSource(title: "Second source")
        section.add(secondCellSource)
        
        return section;

    }
    
    
}
