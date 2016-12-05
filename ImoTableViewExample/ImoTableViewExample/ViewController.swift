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
        
        var section = ImoTableViewSection()
        
        var source = ExampleCellSource()
        section.add(source)
        
        tableView.addSection(section: section)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
