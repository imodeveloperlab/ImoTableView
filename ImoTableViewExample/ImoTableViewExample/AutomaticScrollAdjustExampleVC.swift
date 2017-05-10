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
  
    var table: ImoTableView!
    
    override func exploreTitle() -> String {
        return "Automatic Scroll"
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.table = ImoTableView(on: self.view, insets: UIEdgeInsetsMake(0, 0, 0, 0))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)

        table.adjustContentInsetsForKeyboard(true)
        let section = ImoTableViewSection()
        
        let textField = TextFieldCellSource(staticCellWithTableView: table)
        section.add(textField)
        
        for _ in 0...20 {
            let text = Faker.init().lorem.sentence()
            section.add(TextCellSource(text:text))
        }
        
        self.table.add(section: section, animated: true, animation: .top)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        table.adjustContentInsetsForKeyboard(false)
    }
}


