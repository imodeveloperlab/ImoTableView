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

class AnimatedInsertMultipleSections: BaseViewController {
  
    let faker = Faker.init()
    
    let mainSection = ImoTableViewSection()
    var table: ImoTableView!
    
    override func exploreTitle() -> String {
        return "Animated add Multiple sections"
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //HIDE THE KAYBOARD WHEN TAPPED ARROUND
        self.hideKeyboardWhenTappedAround()
        
        //TABLE
        self.table = ImoTableView(on: self.view)
        
        //ADD ONE CELL ACTION
        let addSource = ActionCellSource(title: "Insert sections")
        mainSection.add(addSource, target: self, #selector(insertNewSections))
        
        //ADD SECTIONS TO TABLE
        table.add(section: mainSection)        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        insertNewSections()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.insertNewSections()
        }
    }
    
    func insertNewSections() {
        
        var sections = [ImoTableViewSection]()

        for i in 0...5 {
            
            let section = ImoTableViewSection()
            section.headerHeight = 25
            section.estimatedHeaderHeight = 0
            section.estimatedFooterHeight = 0
            section.footerHeight = 0

            section.headerTitle = "Header \(i)"
            section.add(sources: getMultipleCells())
            sections.append(section)
        }
        
        table.add(sections: sections, animated: true, animation: .none)
    }
    
    func getMultipleCells() -> [TextCellSource] {
        
        var sources: [TextCellSource] = []
        
        for _ in 0...5 {
            let text = faker.lorem.sentence()
            sources.append(TextCellSource(text: text))
        }
     
        return sources
    }
}
