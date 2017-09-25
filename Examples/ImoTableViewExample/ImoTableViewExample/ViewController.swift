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
    
    var tableView: ImoTableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Examples"
        
        
        tableView = ImoTableView(on: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        var explore: [Explorable] = []
        
        explore.append(BasicsExampleVC())
        explore.append(BasicsActionsExampleVC())
        explore.append(MultipleSectionsExampleVC())
        explore.append(AnimatedAddCellsExample())
        explore.append(AnimatedDeleteCellsExample())
        explore.append(AutomaticScrollAdjustExampleVC())
        explore.append(SpaceExampleVC())
        explore.append(ScrollCatchExampleVC())
        explore.append(UpdateChangedSectionsExample())
        explore.append(AddDeleteIfExistExample())

        
        self.show(examples: explore)
    }
    
    func show(examples: [Explorable]) {
        
        tableView.deleteAllSections()
        let section = ImoTableViewSection()
        
        for example in examples {
            let source = ActionCellSource(title: example.exploreTitle())
            source.object = example as AnyObject
            section.add(source, target: self, #selector(showController))
        }
        
        tableView.add(section: section)
        tableView.update()
    }
    
    func showController(sender: AnyObject) {
        
        let sender = sender as! Explorable
        if let controller = self.navigationController {
            controller.pushViewController(sender.exploreViewController(), animated: true)
        }
    }
}
