//
//  Day.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

class Day {
    
    let date: Double
    var items = [Item]()
    
    init(daysFromNow: Int) {
        
        guard let today = Calendar.current.date(byAdding: .day, value: daysFromNow, to: Date()) else {
            self.date = Date().timeIntervalSince1970
            return
            
        }
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
    
}
