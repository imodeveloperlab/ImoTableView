//
//  TestViewController.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 5/6/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import UIKit
import ImoTableView

class TestViewController: UIViewController {
    
    public var table: ImoTableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.table = ImoTableView(on: self.view)
        self.view.layoutSubviews()
        self.table.tableView.frame = self.view.frame
        self.table.tableView.layoutSubviews()
    }
}

class TestViewControllerKeyboardIntersection: UIViewController {
    
    public var table: ImoTableView!
    public var textField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.textField = UITextField()
        self.view.addSubview(textField)

        self.table = ImoTableView(on: self.view)
        self.view.layoutSubviews()
        self.table.tableView.frame = self.view.frame
        self.table.tableView.layoutSubviews()
        
        print(self.table.tableView.frame)
    }
}
