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

class SpaceExampleVC: BaseViewController {
    
    let space = SpaceCellSource()
    let section = ImoTableViewSection()
    var table: ImoTableView!
    
    override func exploreTitle() -> String {
        return "Space Example"
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        table = ImoTableView(on: self.view)
        
        let faker = Faker.init()
        
        let firstName = TextCellSource(text: faker.name.firstName())
        section.add(firstName)
        
        let lastName = TextCellSource(text: faker.name.lastName())
        section.add(lastName)
        
        let company = TextCellSource(text: faker.company.name())
        section.add(company)
        
        section.add(space)
        
        let app = TextCellSource(text: faker.app.name())
        section.add(app)
        
        table.add(section: section)
        
        space.height = table.spaceBetwenLastCellAndTableBottom()
        table.update()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

}
