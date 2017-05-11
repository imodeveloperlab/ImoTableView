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

class AutomaticScrollAdjustExampleVC: BaseViewController {
  
    let faker = Faker.init()
    
    override func exploreTitle() -> String {
        return "Adjust scroll for keyboard"
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let table = ImoTableView(on: self.view)
        
        table.adjustContentInsetsForKeyboard(true)
        let section = ImoTableViewSection()
        
        for _ in 0...5 {
            let textField = TextFieldCellSource(staticCellWithTableView: table)
            section.add(textField)
        }
        
        for _ in 0...20 {
            let text = faker.lorem.sentence()
            section.add(TextCellSource(text:text))
        }
        
        table.add(section: section)
    }
}
