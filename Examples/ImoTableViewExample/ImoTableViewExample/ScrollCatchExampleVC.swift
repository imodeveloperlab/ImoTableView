
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

class ScrollCatchExampleVC: BaseViewController {
    
    override func exploreTitle() -> String {
        return "Scroll Catch Example"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TABLE
        let table = ImoTableView(on: self.view)
        
        //FAKER
        let faker = Faker.init()
 
        //Lorem section
        let loremSection = ImoTableViewSection()
        loremSection.headerTitle = "Lorem Ipsum"
        
        for _ in 0...30 {
            let text = faker.lorem.sentence()
            loremSection.add(TextCellSource(text:text))
        }
        
        table.add(section: loremSection)
        
        table.scrollViewDidScroll = { scrollView in
            
            print(scrollView.contentOffset)
            
        }
        
    }
}
