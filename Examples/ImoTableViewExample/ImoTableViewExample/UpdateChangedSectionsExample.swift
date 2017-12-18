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

class UpdateChangedSectionsExample: BaseViewController {
  
    let faker = Faker.init()
    
    let mainSection = ImoTableViewSection()

    let firstSection = ImoTableViewSection()
    let secondSection = ImoTableViewSection()
    let thirdSection = ImoTableViewSection()
    
    var table: ImoTableView!
    
    override func exploreTitle() -> String {
        return "Update Changed Sections Example"
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //HIDE THE KAYBOARD WHEN TAPPED ARROUND
        self.hideKeyboardWhenTappedAround()
        
        //TABLE
        self.table = ImoTableView(on: self.view)
        
        let addSourceInFirst = ActionCellSource(title: "Add source in First Section")
        mainSection.add(addSourceInFirst, target: self, #selector(addSourceInFirstSection))
        
        let deleteSourceInFirst = ActionCellSource(title: "Delete source in First Section")
        mainSection.add(deleteSourceInFirst, target: self, #selector(deleteSourceInFirstSection))
        
        let addSourceInSecond = ActionCellSource(title: "Add source in Second Section")
        mainSection.add(addSourceInSecond, target: self, #selector(addSourceInSecondSection))
        
        let addSourceInThird = ActionCellSource(title: "Add source in Third Section")
        mainSection.add(addSourceInThird, target: self, #selector(addSourceInThirdSection))
        
        let updateChanged = ActionCellSource(title: "Update changed sections")
        mainSection.add(updateChanged, target: self, #selector(updateChangedSections))
        
        let sequenceChangeAndUpdate = ActionCellSource(title: "Sequence Change And Update Sections")
        mainSection.add(sequenceChangeAndUpdate, target: self, #selector(sequenceChangeAndUpdateSections))
        
        //ADD SECTIONS TO TABLE
        table.add(section: mainSection)
        
        //SECTIONS
        firstSection.headerTitle = "First section"
        table.add(section: firstSection)
        
        secondSection.headerTitle = "Second section"
        table.add(section: secondSection)
        
        thirdSection.headerTitle = "Third section"
        table.add(section: thirdSection)
    }
    
    func addSourceInFirstSection() {
        
        let text = faker.lorem.sentence()
        let source = TextCellSource(text: text)
        firstSection.add(source)
    }
    
    
    func deleteSourceInFirstSection() {

        if let source = firstSection.firstSource() {
            do {
                try firstSection.delete(source)
            } catch {
                print(error)
            }
        }
    }
    
    func addSourceInSecondSection() {
        
        let text = faker.lorem.sentence()
        let source = TextCellSource(text: text)
        secondSection.add(source)
    }
    
    func addSourceInThirdSection() {
        
        let text = faker.lorem.sentence()
        let source = TextCellSource(text: text)
        thirdSection.add(source)
    }
    
    func updateChangedSections() {
        
        table.updateChangedSections()
        
    }
    
    func sequenceChangeAndUpdateSections()  {
        
        table.updateChangedSections()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
         
            self.addSourceInSecondSection()
            self.addSourceInSecondSection()
            self.table.updateChangedSections()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.addSourceInThirdSection()
            self.addSourceInThirdSection()
            self.addSourceInThirdSection()
            self.table.updateChangedSections()
        }
    }
}
