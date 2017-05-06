//
//  ImoTableViewTestsHelper.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 5/6/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import Foundation
import UIKit

@testable import ImoTableView

func tableView() -> ImoTableView {
    
    let controller = TestViewController()
    UIApplication.shared.keyWindow?.rootViewController = controller
    let _ = controller.view

    return controller.table    
}
