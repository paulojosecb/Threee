//
//  Item.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

class Item: Codable {
    
    var checked: Bool
    var name: String
    
    init(name: String) {
        self.name = name
        self.checked = false
    }
}
