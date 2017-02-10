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

    @IBOutlet weak var tableView: ImoTableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let section = ImoTableViewSection()
        let actionCellSource = ActionCellCellSource(title: "Action")
        section.add(actionCellSource)
        tableView.add(section)
    }
    
}
