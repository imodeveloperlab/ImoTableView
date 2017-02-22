//
//  ImoTableView.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import UIKit

public final class ImoTableView : UIView, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    //TableView
    var tableView : UITableView
    
    /// Set the separator collor of table view
    public var separatorColor : UIColor? {
        get { return self.tableView.separatorColor }
        set { self.tableView.separatorColor = newValue }
    }
    
    /// Separator insset
    public var separatorInset : UIEdgeInsets {
        get { return self.tableView.separatorInset }
        set { self.tableView.separatorInset = newValue }
    }
    
    // Tableview background Color
    override public var backgroundColor: UIColor? {
        get { return self.tableView.backgroundColor }
        set { self.tableView.backgroundColor = newValue }
    }
    
    //This array hold all table sections
    var sections = [ImoTableViewSection]()
    
    //Array off Registered Cells Identifiers
    var registeredCells = [String]()
    
    //Did select source closure
    public var didSelectSource : ((ImoTableViewSource?) -> (Void))?
    
    //Did select cell at index path
    public var didSelectCellAtIndexPath : ((IndexPath) -> (Void))?
    
    public init(on view:UIView, insets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        view.addSubview(self)
        view.edgesConstraints(to: self, insets: insets)
        setUpTable()
    }
    
    override init(frame: CGRect) {
        
        self.tableView = UITableView(frame: frame)
        super.init(frame: frame)
        setUpTable()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        super.init(coder: aDecoder)
        setUpTable()
    }
    
    func setUpTable() {
        
        self.backgroundColor = UIColor.clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.addSubview(self.tableView)
        self.edgesConstraints(to: self.tableView)
    }
    
    // MARK: - UITableView
    
    /// Give to table view number of rows in your section
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - section: Section
    /// - Returns: Number of rows in section
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.sections.indices.contains(section) {
            let section : ImoTableViewSection = self.sections[section]
            return section.count()
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let source = self.cellSourceForIndexPath(indexPath: indexPath) {
            
            self.registerCellClassForSource(source: source)
            return self.cellForSource(tableView, source, cellForRowAt: indexPath)
        }
        
        return UITableViewCell()
    }
    
    func cellForSource(_ tableView: UITableView,
                       _ source: ImoTableViewSource,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = source.staticCell {
            cell.setUpWithSource(source: source)
            return cell as UITableViewCell
        } else {
            return reusableCell(tableView, source, cellForRowAt: indexPath)
        }
    }
    
    func reusableCell(_ tableView: UITableView,
                      _ source: ImoTableViewSource,
                      cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: source.cellClass, for: indexPath) as? ImoTableViewCell {
            cell.setUpWithSource(source: source)
            return cell as UITableViewCell
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
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func update(animated:Bool = false,
                       insertAnimation:UITableViewRowAnimation = .fade,
                       deleteAnimation:UITableViewRowAnimation = .fade,
                       updateAnimation:UITableViewRowAnimation = .fade)
    {
        tableView.reloadData()
    }
    
    
    
    public func statiCell(cellClass:String, nib: UINib?) -> ImoTableViewCell? {
        self.registerCellClass(cellClass: cellClass, nib: nib)
        return tableView.dequeueReusableCell(withIdentifier:cellClass) as! ImoTableViewCell?
    }
    
    // MARK: - UITableView HeaderView
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let section = sectionForIndex(index: section) {
            return section.headerView
        }
        
        return nil
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if let section = sectionForIndex(index: section) {
            return self.heightForHeaderViewInSection(section)
        }
        return UITableViewAutomaticDimension
    }
    
    func heightForHeaderViewInSection(_ section: ImoTableViewSection) -> CGFloat {
        
        if (section.headerView == nil && section.headerTitle == nil) {
            return 0
        } else if let height = section.headerHeight {
            return height
        }
        
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        
        if let section = sectionForIndex(index: section) {
            return section.estimatedHeaderHeight
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if let section = sectionForIndex(index: section) {
            return section.headerTitle
        }
        return nil
    }
    
    
    // MARK: - UITableView FooterView
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if let section = sectionForIndex(index: section) {
            return self.heightForFooterInSection(section)
        }
        return UITableViewAutomaticDimension
    }
    
    func heightForFooterInSection(_ section:ImoTableViewSection) -> CGFloat {
        
        if (section.footerView == nil && section.footerTitle == nil) {
            return 0
        } else if let height = section.footerHeight {
            return height
        }
        
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        
        if let section = sectionForIndex(index: section) {
            return section.estimatedFooterHeight
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if let section = sectionForIndex(index: section) {
            return section.footerView
        }
        
        return nil
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        if let section = sectionForIndex(index: section) {
            return section.footerTitle
        }
        return nil
    }
    
    // MARK: - Sources
    
    /// Add section to table view
    ///
    /// - Parameter section: ImoTableViewSection
    public func add(section:ImoTableViewSection) {
        sections.append(section)
    }
    
    /// Add sections to table view
    ///
    /// - Parameter sections: Array<ImoTableViewSection>
    public func add(sections:[ImoTableViewSection]) {
        
        self.sections.append(contentsOf: sections)
        
    }
    
    /// Delete section at index
    ///
    /// - Parameter index: Int
    public func deleteSection(at index:Int) {
        
        self.sections.remove(at: index)
    }
    
    /// Delete all sections
    public func deleteAllSections() {
        
        sections.removeAll()
    }
    
    /// Delete first
    public func deleteFirstSection() {
        
        sections.removeFirst()
    }
    
    /// Delete last
    public func deleteLastSection() {

        sections.removeLast()
    }
    
    
    public func lastSection() -> ImoTableViewSection? {
        return self.sections.last
    }
    
    /// Get section for given Index
    ///
    /// - Parameter index: Section index
    /// - Returns: ImoTableViewSection?
    public func sectionForIndex(index:Int) -> ImoTableViewSection? {
        
        if self.sections.indices.contains(index) {
            return self.sections[index]
        }
        return nil
    }
    
    /// Get cell source for IndexPath
    ///
    /// - Parameter indexPath: IndexPath
    /// - Returns: ImoTableViewSource?
    public func cellSourceForIndexPath(indexPath:IndexPath) -> ImoTableViewSource? {
        
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
    public func indexFor(section:ImoTableViewSection) -> Int? {
        return self.sections.index(of:section)
    }
    
    /// Register cell class for source
    ///
    /// - Parameter source: ImoTableViewSource
    public func registerCellClassForSource(source:ImoTableViewSource) {
        
        registerCellClass(cellClass: source.cellClass, nib: source.nib)
    }
    
    /// Register cell class
    ///
    /// - Parameters:
    ///   - cellClass: Cell class name, also this name is uniq identifier of the cell
    ///   - nib: Cell nib
    public func registerCellClass(cellClass: String, nib: UINib?) {
        
        if !registeredCells.contains(cellClass) {
            if let _ = nib {
                self.tableView.register(nib, forCellReuseIdentifier:cellClass)
                registeredCells.append(cellClass)
            } else {
                self.tableView.register(NSClassFromString(cellClass), forCellReuseIdentifier:cellClass)
                registeredCells.append(cellClass)
            }
        }
    }
    
    // MARK: - Actions
    
    /// Did select row delegate
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: IndexPath
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let source = self.cellSourceForIndexPath(indexPath: indexPath)
        
        if let action = self.didSelectSource {
            action(source)
        }
        
        //Call sources target with selector
        if let target = source?.target {
            if let selector = source?.selector {
                target.perform(selector)
            }
        }
        
        if let action = self.didSelectCellAtIndexPath {
            action(indexPath)
        }
    }
}
