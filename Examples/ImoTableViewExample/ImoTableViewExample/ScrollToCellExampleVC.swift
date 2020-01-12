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

class ScrollToCellExampleVC: BaseViewController {
    
    let faker = Faker.init()
    let userInfoSection = ImoTableViewSection()
    let bussinesInfoSection = ImoTableViewSection()
    var table: ImoTableView!
    
    override func exploreTitle() -> String {
        return "Scroll to Cell"
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //TABLE
        table = ImoTableView(on: self.view)
        
        //USER INFO SECTION
       
        userInfoSection.headerTitle = "User info"
        
        let firstName = TextCellSource(text: "First Name: \(faker.name.firstName())")
        userInfoSection.add(firstName)
        
        let lastName = TextCellSource(text: "Last Name: \(faker.name.lastName())")
        userInfoSection.add(lastName)
        table.add(section: userInfoSection)
        
        //BUSSINES INFO SECTION
        bussinesInfoSection.headerTitle = "Bussines info"
        
        let company = TextCellSource(text: "Company: \(faker.company.name())")
        bussinesInfoSection.add(company)
        
        let cardNumber = TextCellSource(text: "Credit Card: \(faker.business.creditCardNumber())")
        bussinesInfoSection.add(cardNumber)
        
        let cardType = TextCellSource(text: "Type: \(faker.business.creditCardType())")
        bussinesInfoSection.add(cardType)
        table.add(section: bussinesInfoSection)
  
        //Lorem section
        let loremSection = ImoTableViewSection()
        loremSection.headerTitle = "Lorem Ipsum"
  
        for _ in 0...30 {
            let text = faker.lorem.sentence()
            loremSection.add(TextCellSource(text:text))
        }
        
        table.add(section: loremSection)
        
        //Actions section
        let actionsSection = ImoTableViewSection()
        actionsSection.headerTitle = "Actions section"
        
        let scrollToFirstCellInFisrstSection = ActionCellSource(title: "Scroll to first Cell in first Section")
        actionsSection.add(scrollToFirstCellInFisrstSection, target: self, #selector(scrollToFirstCellInFisrstSectionAction))
        
        let scrollToLastCellInSecondSection = ActionCellSource(title: "Scroll to last Cell in second Section")
        actionsSection.add(scrollToLastCellInSecondSection, target: self, #selector(scrollToLastCellInSecondSectionAction))
        
        table.add(section: actionsSection)
    }
    
    @objc func scrollToFirstCellInFisrstSectionAction()  {        
        if let source = userInfoSection.firstSource() {
            table.scrollToCell(source: source, at: .top, animated: true)
        }
    }
    
    @objc func scrollToLastCellInSecondSectionAction() {
        if let source = bussinesInfoSection.lastSource() {
            table.scrollToCell(source: source, at: .bottom, animated: true)
        }
    }
}
