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

class AnimatedDeleteCellsExample: BaseViewController {
  
    let faker = Faker.init()
    
    let mainSection = ImoTableViewSection()
    let secondSection = ImoTableViewSection()
    var table: ImoTableView!
    
    override func exploreTitle() -> String {
        return "Animated delete Cells"
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.table = ImoTableView(on: self.view)
        
        let deleteFirstSource = ActionCellSource(title: "Delete first cell")
        mainSection.add(deleteFirstSource, target: self, #selector(deleteFirst))
        
        let deleteLastSource = ActionCellSource(title: "Delete last cell")
        mainSection.add(deleteLastSource, target: self, #selector(deleteLast))
        
        let deleteAllSource = ActionCellSource(title: "Delete all cells")
        mainSection.add(deleteAllSource, target: self, #selector(deleteAll))

        secondSection.headerTitle = "Cells"
        
        addMultipleCells()
        
        table.add(section: mainSection)
        table.add(section: secondSection)
    }
    
    func addMultipleCells() {
        
        var sources:[TextCellSource] = []
        
        for _ in 0...5 {
            let text = faker.lorem.sentence()
            sources.append(TextCellSource(text: text))
        }
        
        secondSection.add(sources: sources)
    }
    
    func deleteFirst()  {
        
        if let source = secondSection.firstSource() {
            table.delete(source: source, in: secondSection, animated: true, animation: .left)
        }
    }
    
    func deleteLast()  {
        
        if let source = secondSection.lastSource() {
            table.delete(source: source, in: secondSection, animated: true, animation: .right)
        }
    }
    
    func deleteAll()  {
        
        let allSources = secondSection.allSources()
        table.delete(sources: allSources, in: secondSection, animated: true, animation: .top)
    }
    
    
}
