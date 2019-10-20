//
//  Day.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

class Day: NSObject, Codable {

    var id: UUID
    var date: Date
    var items : [Item]? = []
    
    init(daysFromNow: Int) {
        self.id = UUID()
        let today = Calendar.current.date(byAdding: .day, value: daysFromNow, to: Date()) ?? Date()
        
        self.date = today
    }
    
    func isDayCompleted() -> Bool {
        guard let items = items else { return false }

        let result = items.reduce(true, { (accumulator, item) -> Bool in
            return accumulator && item.checked
        })
        
        return result && items.count == 3
    }
    
    func add(_ item: Item) {
        
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
    
//    func transform() -> [String: Any] {
//        
//        var dict: [String: Any] = [String: Any]()
//        
//        dict["date"] = date
//        
//        guard let items = items else { return dict }
//        
//        var itemsDict: [String: Any] = [String: Any]()
//        
//        for (index, item) in items.enumerated() {
//            itemsDict["\(index)"] = item.transform()
//        }
//        
//        dict["items"] = itemsDict
//        
//        return dict
//    }
    
}
