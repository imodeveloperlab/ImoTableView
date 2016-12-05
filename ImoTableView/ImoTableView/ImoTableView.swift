//
//  ImoTableView.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import UIKit

open class ImoTableView : UITableView, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var sections = Array<ImoTableViewSection>()
    var registeredCells = Array<String>()
    
    override init(frame: CGRect, style: UITableViewStyle) {
        
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
   
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
        
    }
    
    // MARK: - UITableView
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.sections.indices.contains(section)
        {
            let section : ImoTableViewSection = self.sections[section]
            return section.count()
        }

        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let source = self.cellSourceForIndexPath(indexPath: indexPath) {
            
            self.registerCellClassForSource(source: source)
            let cell : ImoTableViewCell = tableView.dequeueReusableCell(withIdentifier: source.cellClass, for: indexPath) as! ImoTableViewCell
            cell.setUpWithSource(source: source)
            
            return cell as UITableViewCell
        }
        
        return UITableViewCell()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int  {
        
        return sections.count
    }
    
    // MARK: - Sources
    
    public func addSection(section:ImoTableViewSection) {
        
        sections.append(section)
    }
    
    
    public func cellSourceForIndexPath(indexPath:IndexPath) -> ImoTableViewSource? {
        
        if self.sections.indices.contains(indexPath.section) {
            
            let section : ImoTableViewSection = self.sections[indexPath.section]
            return section.get(sourceAtIndex: indexPath.row)
        }
        
        return nil
    }
    
    
    public func registerCellClassForSource(source:ImoTableViewSource) {
        
        if !registeredCells.contains(source.cellClass) {
            
            if let _ = source.nib {

                self.register(source.nib, forCellReuseIdentifier:source.cellClass)
                registeredCells.append(source.cellClass)
            }
            else {
                self.register(NSClassFromString(source.cellClass), forCellReuseIdentifier:source.cellClass)
                registeredCells.append(source.cellClass)
            }
        }
    }
}
