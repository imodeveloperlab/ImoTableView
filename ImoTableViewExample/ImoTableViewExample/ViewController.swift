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
    var section1 = ImoTableSection()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Create an table andd ad on self.view
        tableView = ImoTableView(on: self.view, insets: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))

        if let tableView = self.tableView {
            
            //Add one section
            let addSectionCellSource = ActionCellSource(title: "- Add section")
            section.add(addSectionCellSource, target:self, #selector(addSection))
            
            //Add multiple sections
            let addSectionsCellSource = ActionCellSource(title: "Add multiple sections")
            section.add(addSectionsCellSource, target:self, #selector(addSections))
            
            //Delete last section
            let deleteSectionCellSource = ActionCellSource(title: "Delete last section")
            section.add(deleteSectionCellSource, target:self, #selector(deleteLastSection))
            
            //Mix updates
            let mixUpdatesCellSource = ActionCellSource(title: "Mix updates")
            section.add(mixUpdatesCellSource, target:self, #selector(mixedUpdates))
            
            //Mix updates
            let updateCellSource = ActionCellSource(title: "Update last section")
            section.add(updateCellSource, target:self, #selector(updateLastSection))
            
            
            //Mix updates
            let addRowCellSource = ActionCellSource(title: "Add row in section")
            section.add(addRowCellSource, target:self, #selector(addRowInSection))

            //Add section to table View
            tableView.add(section:section)
            
            tableView.update()
            
            
            
            let source = ImoTableSource(cellClass:"Ion")
            
            section1.addSource(source: source)
            
            tableView.tableSections = [section1];
      
        }
    }
    
    func addRowInSection() {
        
        let rowCellSource = ActionCellSource(title: "New ro in main section")
        section.add(rowCellSource)
        //tableView?.update()
        
        let source = ImoTableSource(cellClass:"Ion")
        section1.addSource(source: source)
        section1.ion = "Ion"
    }
    
    func addSections() {
        
        if let tableView = self.tableView {
            
            var sections : [ImoTableViewSection] = []
            sections.append(makeSection(with: "First section"))
            sections.append(makeSection(with: "Second section"))
            tableView.add(sections:sections)
            tableView.update(animated: true)
        }
    }
    
    func addSection() {
        
        if let tableView = self.tableView {

            tableView.add(section:makeSection(with: "New section"))
            tableView.add(section:makeSection(with: "New section"))
            tableView.add(section:makeSection(with: "New section"))
            tableView.add(section:makeSection(with: "New section"))
            tableView.add(section:makeSection(with: "New section"))
            tableView.update(animated: true)
        }
    }
    
    
    func deleteLastSection() {
        
        if let tableView = self.tableView {
            
            tableView.deleteLastSection()
            tableView.update(animated: true)
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
            
            tableView.update(animated: true)
            
        }
    }
    
    func updateLastSection() {
        if let tableView = self.tableView {
            if let section = tableView.lastSection() {
                
                section.add(ActionCellSource(title: "New source"))
                tableView.update(animated: true)
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
