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
            
            if let cell = source.staticCell
            {
                cell.setUpWithSource(source: source)
                return cell as UITableViewCell
            }
            else
            {
                let cell : ImoTableViewCell = tableView.dequeueReusableCell(withIdentifier: source.cellClass, for: indexPath) as! ImoTableViewCell
                cell.setUpWithSource(source: source)
                return cell as UITableViewCell
            }
        }
        
        return UITableViewCell()
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let source = self.cellSourceForIndexPath(indexPath: indexPath) {
            
            if let height = source.height {
                return height
            }
            
        }
        
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
        
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let section = sectionForIndex(index: section) {
            return section.headerView
        }
        
        return nil
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if let section = sectionForIndex(index: section) {
            
            if let height = section.headerHeight {
                return height
            }
        }
        
        return UITableViewAutomaticDimension
        
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if let section = sectionForIndex(index: section) {
            if let height = section.footerHeight {
                return height
            }
        }
        
        return UITableViewAutomaticDimension
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int  {
        
        return sections.count
    }
    
    // MARK: - Sources
    
    public func addSection(section:ImoTableViewSection) {
        
        sections.append(section)
    }
    
    
    public func sectionForIndex(index:Int) -> ImoTableViewSection? {
        
        if self.sections.indices.contains(index) {
            return self.sections[index]
        }
        
        return nil
    }
    
    
    
    public func cellSourceForIndexPath(indexPath:IndexPath) -> ImoTableViewSource? {
        
        if self.sections.indices.contains(indexPath.section) {
            
            let section : ImoTableViewSection = self.sections[indexPath.section]
            return section.get(sourceAtIndex: indexPath.row)
        }
        
        return nil
    }
    
    
    public func registerCellClassForSource(source:ImoTableViewSource) {
        
        registerCellClass(cellClass: source.cellClass,nib: source.nib)
    }
    
    public func registerCellClass(cellClass:String,nib:UINib?) {
        
        if !registeredCells.contains(cellClass) {
            
            if let _ = nib {
                
                self.register(nib, forCellReuseIdentifier:cellClass)
                registeredCells.append(cellClass)
            }
            else {
                self.register(NSClassFromString(cellClass), forCellReuseIdentifier:cellClass)
                registeredCells.append(cellClass)
            }
        }
        
    }
    
}
