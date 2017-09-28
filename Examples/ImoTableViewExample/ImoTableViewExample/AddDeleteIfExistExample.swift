//
//  AutomaticScrollAdjustExampleVC.swift
//  ImoTableViewExample
//
//  Created by Borinschi Ivan on 5/10/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import Foundation
import UIKit
import ImoTableView
import Fakery

class AddDeleteIfExistExample: BaseViewController {
  
    let faker = Faker.init()
    
    let mainSection = ImoTableViewSection()
    let firstSection = ImoTableViewSection()
    let secondSection = ImoTableViewSection()
    
    var table: ImoTableView!
    
    override func exploreTitle() -> String {
        return "Add / Delete if exist"
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //HIDE THE KAYBOARD WHEN TAPPED ARROUND
        self.hideKeyboardWhenTappedAround()
        
        //TABLE
        self.table = ImoTableView(on: self.view)
        
        let addSourceInFirst = ActionCellSource(title: "Add First Comparable")
        mainSection.add(addSourceInFirst, target: self, #selector(addFirstSource))
        
        let deleteSourceInFirst = ActionCellSource(title: "Delete First Comparable")
        mainSection.add(deleteSourceInFirst, target: self, #selector(deleteFirstSource))
        
        let addSourceInSecond = ActionCellSource(title: "Add Second Comparable")
        mainSection.add(addSourceInSecond, target: self, #selector(addSecondSource))
        
        let deleteSourceInSecond = ActionCellSource(title: "Delete Second Comparable")
        mainSection.add(deleteSourceInSecond, target: self, #selector(deleteSecondSource))
        
        //ADD SECTIONS TO TABLE
        table.add(section: mainSection)
        table.add(section: firstSection)
        
        table.add(section: secondSection)
        
        let firstName = TextCellSource(text: "First Name: \(faker.name.firstName())")
        firstSection.add(firstName)
        
        let lastName = TextCellSource(text: "Last Name: \(faker.name.lastName())")
        firstSection.add(lastName)
        
        let company = TextCellSource(text: "Company: \(faker.company.name())")
        secondSection.add(company)
        
    }
    
    func addFirstSource() {
        
        let source = ComparableCellSource(message: "First Comparable")
        firstSection.addIfNotExist(source: source)
        table.updateChangedSections()
    }
    
    func deleteFirstSource() {

        let source = ComparableCellSource(message: "First Comparable")
        firstSection.deleteIfExist(source: source)
        table.updateChangedSections()
    }
    
    func addSecondSource() {
        
        let source = ComparableCellSource(message: "Second Comparable")
        secondSection.addIfNotExist(source: source)
        table.updateChangedSections()
    }
    
    func deleteSecondSource() {
        
        let source = ComparableCellSource(message: "Second Comparable")
        secondSection.deleteIfExist(source: source)
        table.updateChangedSections()
    }
}
