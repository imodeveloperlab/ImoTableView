//
//  ViewController.swift
//  ImoTableViewExample
//
//  Created by Borinschi Ivan on 12/5/16.
//  Copyright © 2016 Imodeveloperlab. All rights reserved.
//

import UIKit
import ImoTableView

class ViewController: UIViewController {

    //ImoTableView reference from ViewController
    @IBOutlet weak var tableView: ImoTableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Create new section
        let section = ImoTableViewSection()
        //Create new cellSource
        let actionCellSource = ActionCellSource(title: "Action")
        //Add cellSource to section
        section.add(actionCellSource)
        //Add section to table View
        tableView.add(section)
        //Reload table
        tableView.reloadData()
    }
}
