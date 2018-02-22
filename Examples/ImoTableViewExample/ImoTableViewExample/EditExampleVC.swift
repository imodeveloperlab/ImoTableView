
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

class EditExampleVC: BaseViewController {
    
    override func exploreTitle() -> String {
        return "Edit Example"
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //TABLE
        let table = ImoTableView(on: self.view)
        
        //SECTION
        let section = ImoTableViewSection()
        
        //FAKER
        let faker = Faker.init()
        
        let firstName = TextCellSource(text: "First Name: \(faker.name.firstName())")
        section.add(firstName)
        firstName.canBeEdited = true
        firstName.deleteButtonTitle = "Delete First Name"
        
        let lastName = TextCellSource(text: "Last Name: \(faker.name.lastName())")
        section.add(lastName)
        lastName.canBeEdited = true
        lastName.deleteButtonTitle = "Delete"
        
        let company = TextCellSource(text: "Company: \(faker.company.name())")
        section.add(company)
        
        table.add(section: section)
        
        table.deleteSource = { source in
            table.delete(source: source, in: section, animated: true, animation: .fade)
        }
    }
}
