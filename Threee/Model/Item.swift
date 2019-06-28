//
//  Item.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

struct Item: Codable {
    
    var checked: Bool
    var name: String
    
    init() {
        name = ""
        checked = false
    }
    
    func transform() -> [String: Any] {
        var dict: [String: Any] = [String: Any]()
        
        dict["checked"] = checked
        dict["name"] = name
        
        return dict
    }
    
}
