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
        self.hideKeyboardWhenTappedAround()
        self.table = ImoTableView(on: self.view)
        
        let addSource = ActionCellSource(title: "Add new Cell")
        mainSection.add(addSource, target: self, #selector(addNewCell))
        
        let addMultipleSource = ActionCellSource(title: "Add multiple Cells")
        mainSection.add(addMultipleSource, target: self, #selector(addMultipleCells))

        secondSection.headerTitle = "Cells"
        
        table.add(section: mainSection)
        table.add(section: secondSection)
    }
    
    func addNewCell() {
        
        let text = faker.lorem.sentence()
        let source = TextCellSource(text: text)
        table.add(source: source, in: secondSection, animated: true, animation: .top)
    }
    
    func addMultipleCells() {
        
        var sources:[TextCellSource] = []
        
        for _ in 0...10 {
            let text = faker.lorem.sentence()
            sources.append(TextCellSource(text: text))
        }
        
        table.add(sources: sources, in: secondSection, animated: true, animation: .none)
    }
}
