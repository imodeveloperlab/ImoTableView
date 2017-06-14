//
//  BaseViewController.swift
//  ImoTableViewExample
//
//  Created by Borinschi Ivan on 5/10/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, Explorable {
    
    func exploreTitle() -> String {
        return "Base title"
    }
    
    func exploreViewController() -> UIViewController {
        return self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = exploreTitle()
    }

}
