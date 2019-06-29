//
//  Day.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

class Day: NSObject, Codable {

    var id: String
    var date: Double
    var items = [Item]()
    
    init(daysFromNow: Int) {
        self.id = UUID().uuidString
        let today = Calendar.current.date(byAdding: .day, value: daysFromNow, to: Date()) ?? Date()
        
        self.date = today.timeIntervalSince1970
        self.items = [Item(), Item(), Item()]
    }
    
    func isDayCompleted() -> Bool {
        
        return items.reduce(true, { (accumulator, item) -> Bool in
            return accumulator && item.checked
        })
    }
    
    func edit(item: Int, newValue: String) {
        items[item].name = newValue
    }
    
    func toggle(item: Int) {
        items[item].checked = !items[item].checked
    }
    
    func transform() -> [String: Any] {
        var dict: [String: Any] = [String: Any]()
        
        dict["date"] = date
        
        var itemsDict: [String: Any] = [String: Any]()
        
        for item in items {
            itemsDict["\(item.id)"] = item.transform()
        }
        
        dict["items"] = itemsDict
        
        return dict
    }
    
}
