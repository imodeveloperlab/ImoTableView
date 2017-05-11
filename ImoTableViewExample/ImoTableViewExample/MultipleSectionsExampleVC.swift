//
//  MultipleSectionsExampleVC.swift
//  ImoTableViewExample
//
//  Created by Borinschi Ivan on 5/10/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import Foundation
import UIKit
import ImoTableView
import Fakery

class MultipleSectionsExampleVC: BaseViewController {
    
    let faker = Faker.init()
    
    override func exploreTitle() -> String {
        return "Multiple Sections Example"
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let table = ImoTableView(on: self.view)
        
        //User info section
        let userInfoSection = ImoTableViewSection()
        userInfoSection.headerTitle = "User info"
        
        let firstName = TextCellSource(text: faker.name.firstName())
        userInfoSection.add(firstName)
        
        let lastName = TextCellSource(text: faker.name.lastName())
        userInfoSection.add(lastName)
        table.add(section: userInfoSection)
        
        //Bussines info section
        let bussinesInfoSection = ImoTableViewSection()
        bussinesInfoSection.headerTitle = "Bussines info"
        
        let company = TextCellSource(text: faker.company.name())
        bussinesInfoSection.add(company)
        
        let cardNumber = TextCellSource(text: faker.business.creditCardNumber())
        bussinesInfoSection.add(cardNumber)
        
        let cardType = TextCellSource(text: faker.business.creditCardType())
        bussinesInfoSection.add(cardType)
        table.add(section: bussinesInfoSection)
  
        //Lorem section
        let loremSection = ImoTableViewSection()
        loremSection.headerTitle = "Lorem Ipsum"
  
        for _ in 0...20 {
            let text = faker.lorem.sentence()
            loremSection.add(TextCellSource(text:text))
        }
        
        table.add(section: loremSection)
        
    }

}
