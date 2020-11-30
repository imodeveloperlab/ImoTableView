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

class AnimatedAddCellsExample: BaseViewController {
  
    let faker = Faker.init()
    
    let mainSection = ImoTableViewSection()
    let secondSection = ImoTableViewSection()
    var table: ImoTableView!
    
    override func exploreTitle() -> String {
        return "Animated add Cells"
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //HIDE THE KAYBOARD WHEN TAPPED ARROUND
        self.hideKeyboardWhenTappedAround()
        
        //TABLE
        self.table = ImoTableView(on: self.view)
        
        //ADD ONE CELL ACTION
        let addSource = ActionCellSource(title: "Add new Cell")
        mainSection.add(addSource, target: self, #selector(addNewCell))
        
        //ADD MULTIPLE CELL'S ACTION
        let addMultipleSource = ActionCellSource(title: "Add multiple Cells")
        mainSection.add(addMultipleSource, target: self, #selector(addMultipleCells))

        //HEADER TITLE
        secondSection.headerTitle = "Cells"
        
        //ADD SECTIONS TO TABLE
        table.add(section: mainSection)
        table.add(section: secondSection)
    }
    
    @objc func addNewCell() {
        
        let text = faker.lorem.sentence()
        let source = TextCellSource(text: text)
        table.add(source: source, in: secondSection, animated: true, animation: .top)
    }
    
    @objc func addMultipleCells() {
        
        var sources:[TextCellSource] = []
        
        for _ in 0...10 {
            let text = faker.lorem.sentence()
            sources.append(TextCellSource(text: text))
        }
        
        table.add(sources: sources, in: secondSection, animated: true, animation: .top)
    }
}
