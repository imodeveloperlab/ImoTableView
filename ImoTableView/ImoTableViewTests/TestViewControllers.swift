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
        table = ImoTableView(on: view)
        view.layoutSubviews()
        table.view.frame = view.frame
        table.view.layoutSubviews()
    }
}

class TestViewControllerKeyboardIntersection: UIViewController {
    
    public var table: ImoTableView!
    public var textField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        textField = UITextField()
        view.addSubview(textField)

        table = ImoTableView(on: view)
        view.layoutSubviews()
        table.view.frame = view.frame
        table.view.layoutSubviews()
    }
}
