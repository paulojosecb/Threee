//
//  Day.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

class Day: NSObject, Codable {

    var date: Double
    var items : [Item]? = []
    
    init(daysFromNow: Int) {
        let today = Calendar.current.date(byAdding: .day, value: daysFromNow, to: Date()) ?? Date()
        
        self.date = today.timeIntervalSince1970
    }
    
    func isDayCompleted() -> Bool {
        guard let items = items else { return false }

        return items.reduce(true, { (accumulator, item) -> Bool in
            return accumulator && item.checked
        })
    }
    
    func add(item: Item) {
        
        if (items == nil) {
            self.items = [Item]()
        }
    
        self.items?.append(item)
    }
    
    func edit(item: Int, newValue: String) {
        guard let items = items else { return  }

        items[item].name = newValue
    }
    
    func toggle(item: Int) {
        guard let items = items else { return }
        items[item].checked = !items[item].checked
    }
    
    func transform() -> [String: Any] {
        
        var dict: [String: Any] = [String: Any]()
        
        dict["date"] = date
        
        guard let items = items else { return dict }
        
        var itemsDict: [String: Any] = [String: Any]()
        
        for (index, item) in items.enumerated() {
            itemsDict["\(index)"] = item.transform()
        }
        
        dict["items"] = itemsDict
        
        return dict
    }
    
}
