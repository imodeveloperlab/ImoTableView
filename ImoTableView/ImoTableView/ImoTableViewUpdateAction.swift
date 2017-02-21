//
//  ImoTableViewUpdateAction.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 2/21/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import Foundation

struct ImoTableViewUpdateIndex {
    var index : Int
    var action : ImoTableViewUpdateAction
}

enum ImoTableViewUpdateAction {
    case InsertSection
    case DeleteSection
}
