//
//  Day.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

struct Day: Codable {
    
    let date: Double
    var items = [Item]()
    
    init(daysFromNow: Int) {
        
        let today = Calendar.current.date(byAdding: .day, value: daysFromNow, to: Date()) ?? Date()
        
        self.date = today.timeIntervalSince1970
        self.items = [Item(), Item(), Item()]
    }
    
    func isDayCompleted() -> Bool {
        
        return items.reduce(true, { (accumulator, item) -> Bool in
            return accumulator && item.checked
        })
    }
    
    mutating func edit(item: Int, newValue: String) {
        items[item].name = newValue
    }
    
    mutating func toggle(item: Int) {
        items[item].checked = !items[item].checked
    }
    
    func transform() -> [String: Any] {
        var dict: [String: Any] = [String: Any]()
        
        dict["date"] = date
        
        var itemsDict: [String: Any] = [String: Any]()
        
        for (index, item) in items.enumerated() {
            itemsDict["\(index)"] = item.transform()
        }
        
        dict["items"] = itemsDict
        
        return dict
    }
    
}
