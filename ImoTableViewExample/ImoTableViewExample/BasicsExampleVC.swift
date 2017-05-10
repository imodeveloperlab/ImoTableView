
//
//  BasicsExample.swift
//  ImoTableViewExample
//
//  Created by Borinschi Ivan on 5/10/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import Foundation
import UIKit
import ImoTableView
import Fakery

class BasicsExampleVC: BaseViewController {
    
    override func exploreTitle() -> String {
        return "Basic Example"
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let table = ImoTableView(on: self.view)
        let section = ImoTableViewSection()
        
        let faker = Faker.init()
        
        let firstName = TextCellSource(text: faker.name.firstName())
        section.add(firstName)
        
        let lastName = TextCellSource(text: faker.name.lastName())
        section.add(lastName)
        
        let company = TextCellSource(text: faker.company.name())
        section.add(company)
        
        table.add(section: section)
    }

}
