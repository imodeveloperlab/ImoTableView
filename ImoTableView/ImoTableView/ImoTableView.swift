//
//  ImoTableView.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import UIKit

public final class ImoTableView: UIView, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    //TableView
    var tableView: UITableView
    
    //TableView
    public var view: UITableView {
        return self.tableView
    }
    
    //For storing original table UIEdgeInsets when an keyboard appears on screen
    //table will change its content insets and after when keyboard disappears
    //we need to set previous table ContentInset and ScrollIndicatorInsets
    public var storedContentInset: UIEdgeInsets?
    public var storedScrollIndicatorInsets: UIEdgeInsets?
    
    /// Set the separator color of table view
    public var separatorColor: UIColor? {
        get { return self.tableView.separatorColor }
        set { self.tableView.separatorColor = newValue }
    }
    
    /// Separator inset
    public var separatorInset: UIEdgeInsets {
        get { return self.tableView.separatorInset }
        set { self.tableView.separatorInset = newValue }
    }
    
    /// ContentInset inset
    public var contentInset: UIEdgeInsets {
        get { return self.tableView.contentInset }
        set { self.tableView.contentInset = newValue }
    }
    
    /// ScrollIndicatorInsets inset
    public var scrollIndicatorInsets: UIEdgeInsets {
        get { return self.tableView.scrollIndicatorInsets }
        set { self.tableView.scrollIndicatorInsets = newValue }
    }
    
    // Tableview background Color
    override public var backgroundColor: UIColor? {
        get { return self.tableView.backgroundColor }
        set { self.tableView.backgroundColor = newValue }
    }
    
    //Estimated height for row
    var estimatedHeightForRow: CGFloat = 40
    
    //Is keyboard on screen
    var isKeyboardOnScreen: Bool = false
    
    //This array hold all table sections
    var sections = [ImoTableViewSection]()
    
    //Array off Registered Cells Identifiers
    var registeredCells = [String]()
    
    //Delete source
    public var deleteSource: ((ImoTableViewSource) -> Void)?
    
    //Did select source closure
    public var didSelectSource: ((ImoTableViewSource?) -> Void)?
    
    //Did select cell at index path
    public var didSelectCellAtIndexPath: ((IndexPath) -> Void)?
    
    // MARK: - Scroll view closures
    //Scroll view did scroll
    public var scrollViewDidScroll: ((UIScrollView) -> Void)?
    
    //Scroll view did zoom
    public var scrollViewDidZoom: ((UIScrollView) -> Void)?
    
    //Scroll view will begin dragging
    public var scrollViewWillBeginDragging: ((UIScrollView) -> Void)?
    
    //Scroll view will end dragging
    public typealias ScrollVelocity = CGPoint
    public typealias TargetContentOffset = UnsafeMutablePointer<CGPoint>
    public var scrollViewWillEndDragging: ((UIScrollView, ScrollVelocity, TargetContentOffset) -> Void)?
    
    //Scroll view did end dragging
    public typealias WillDecelerate = Bool
    public var scrollViewDidEndDragging: ((UIScrollView, WillDecelerate) -> Void)?
    
    //Scroll view will begin decelerating
    public var scrollViewWillBeginDecelerating: ((UIScrollView) -> Void)?
    
    //Scroll view did end decelerating
    public var scrollViewDidEndDecelerating: ((UIScrollView) -> Void)?
    
    //Scroll did end scrolling animation
    public var scrollViewDidEndScrollingAnimation: ((UIScrollView) -> Void)?
    
    //View for zooming
    public var viewForZooming: ((UIScrollView) -> (UIView?))?
    
    //Scroll view will begin zooming
    public var scrollViewWillBeginZooming: ((UIScrollView, UIView?) -> Void)?
    
    //Scroll view did end zooming
    public typealias AtScale = CGFloat
    public var scrollViewDidEndZooming: ((UIScrollView, UIView?, AtScale) -> Void)?
    
    //Scroll view should scroll to top
    public var scrollViewShouldScrollToTop: ((UIScrollView) -> (Bool))?
    
    //Scroll view did scroll to top
    public var scrollViewDidScrollToTop: ((UIScrollView) -> Void)?
    
    // MARK: - Initialization
    
    public init(on view: UIView, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        
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
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
        self.addSubview(self.tableView)
        self.edgesConstraints(to: self.tableView)
    }
    
    // MARK: - UITableView
    
    /// Give to table view number of rows in your section
    ///
    /// - Parameters:
    /// - tableView: UITableView
    /// - section: Section
    /// - Returns: Number of rows in section
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.sections.indices.contains(section) {
            let section: ImoTableViewSection = self.sections[section]
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
    
    public func cellForSource(_ tableView: UITableView,
                              _ source: ImoTableViewSource,
                              cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = source.staticCell else {
            return reusableCell(tableView, source, cellForRowAt: indexPath)
        }
        
        cell.setUpWithSource(source: source)
        return cell as UITableViewCell
    }
    
    //
    public func reusableCell(_ tableView: UITableView,
                             _ source: ImoTableViewSource,
                             cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: source.cellClass, for: indexPath) as? ImoTableViewCell {
            cell.setUpWithSource(source: source)
            return cell as UITableViewCell
        }
        
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let source = self.cellSourceForIndexPath(indexPath: indexPath),
              let height = source.height else {
            return UITableView.automaticDimension
        }
        
        return height
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let source = self.cellSourceForIndexPath(indexPath: indexPath) else {            
            return UITableView.automaticDimension
        }
        
        return source.estimatedHeightForRow
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let source = self.cellSourceForIndexPath(indexPath: indexPath) else {
            return
        }
        
        source.estimatedHeightForRow = cell.frame.size.height
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func update() {
        tableView.reloadData()
    }
    
    public func staticCell(cellClass: String, nib: UINib?) -> ImoTableViewCell? {
        self.registerCellClass(cellClass: cellClass, nib: nib)
        
        if let cell = tableView.dequeueReusableCell(withIdentifier:cellClass) {
            if cell.isKind(of: ImoTableViewCell.classForCoder()) {
                return cell as? ImoTableViewCell
            }
        }
        
        return ImoTableViewCell()
    }
    
    // MARK: - Edit / Delete sources
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if let source = self.cellSourceForIndexPath(indexPath: indexPath) {
            return source.canBeEdited
        }
        
        return false
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            if let source = self.cellSourceForIndexPath(indexPath: indexPath) {
                if let closure = deleteSource {
                    closure(source)
                }
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        if let source = self.cellSourceForIndexPath(indexPath: indexPath) {
            return source.deleteButtonTitle
        }
        
        return nil
    }
    
    public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        if view.isEditing {
            return .none
        } else {
            return .delete
        }        
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
        return UITableView.automaticDimension
    }
    
    func heightForHeaderViewInSection(_ section: ImoTableViewSection) -> CGFloat {
        
        if (section.headerView == nil && section.headerTitle == nil) {
            return 0
        } else if let height = section.headerHeight {
            return height
        }
        
        return section.estimatedHeaderHeight
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
        return UITableView.automaticDimension
    }
    
    func heightForFooterInSection(_ section: ImoTableViewSection) -> CGFloat {
        
        if (section.footerView == nil && section.footerTitle == nil) {
            return 0
        } else if let height = section.footerHeight {
            return height
        }
        
        return section.estimatedFooterHeight
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
    
    /// Register cell class for source
    ///
    /// - Parameter source: ImoTableViewSource
    public func registerCellClassForSource(source: ImoTableViewSource) {
        
        registerCellClass(cellClass: source.cellClass, nib: source.nib, cellAnyClass: source.cellAnyClass)
    }
    
    /// Register cell class
    ///
    /// - Parameters:
    /// - cellClass: Cell class name, also this name is uniq identifier of the cell
    /// - nib: Cell nib
    public func registerCellClass(cellClass: String, nib: UINib?, cellAnyClass: AnyClass? = nil) {
        
        if !registeredCells.contains(cellClass) {
            
            if let cellAnyClass = cellAnyClass {
                self.tableView.register(cellAnyClass, forCellReuseIdentifier: cellClass)
            } else if nib != nil {
                self.tableView.register(nib, forCellReuseIdentifier:cellClass)
                registeredCells.append(cellClass)
            } else {
                self.tableView.register(NSClassFromString(cellClass), forCellReuseIdentifier:cellClass)
                registeredCells.append(cellClass)
            }
        }
    }
    
    /// Set alpha to zero
    /// - Parameter animated: Bool
    public func setAlphaToZero(animated: Bool = false) {
        
        if animated {
            UIView.animate(withDuration: 0.4) {
                self.alpha = 0
            }
        } else {
            alpha = 0
        }
    }
    
    /// Show if alpha is zero
    /// - Parameter animated: Bool
    public func showIfAlphaIsZero(animated: Bool = false) {
        
        if animated {
            UIView.animate(withDuration: 0.4) {
                self.alpha = 1
            }
        } else {
            alpha = 11
        }
    }
    
}

public extension ImoTableView {
    
    func getAllSources<T>() -> [T] {
        var sources: [T] = []
        for section in self.getAllSections() {
            for source in section.allSources() {
                if let source = source as? T {
                    sources.append(source)
                }
            }
        }
        
        return sources
    }
}
