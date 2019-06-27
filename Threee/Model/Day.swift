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
    var item1: String = ""
    var item2: String = ""
    var item3: String = ""
    
    init(daysFromNow: Int) {
        guard let today = Calendar.current.date(byAdding: .day, value: daysFromNow, to: Date()) else {
            self.date = Date().timeIntervalSince1970
            return
            
        }
        self.date = today.timeIntervalSince1970
    }
    
}
