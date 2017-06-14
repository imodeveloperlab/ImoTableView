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

class BasicsActionsExampleVC: BaseViewController {
    
    override func exploreTitle() -> String {
        return "Basic Actions Example"
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //TABLE
        let table = ImoTableView(on: self.view)
        
        //SECTION
        let section = ImoTableViewSection()
        
        //FAKER
        let faker = Faker.init()
        
        //1. First way
        let appNameCell = ActionCellSource(title: "App name: \(faker.app.name())")
        section.add(appNameCell, target: self, #selector(didSelectAppName))
        
        //2. Second way
        let appAuthorCell = ActionCellSource(title: "Author: \(faker.app.author())")
        appAuthorCell.target = self
        appAuthorCell.selector = #selector(didSelectAppAuthor)
        section.add(appAuthorCell)
        
        //3. Third way
        let appVersion = faker.app.version()
        let appVersionCell = ActionCellSource(title: "App version: \(appVersion)")
        appVersionCell.target = self
        appVersionCell.object = appVersion as AnyObject
        appVersionCell.selector = #selector(didSelectAppVersion)
        section.add(appVersionCell)
        
        table.add(section: section)
    }
    
    func didSelectAppVersion(sender: AnyObject) {
        
        let version = sender as! String
        show(message: "Did select version \(version)")
    }
    
    func didSelectAppAuthor() {

        self.show(message: "Did select app author")
    }
    
    func didSelectAppName() {
        
        show(message: "Did select app name")
    }
}
