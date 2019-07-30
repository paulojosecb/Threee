//
//  User.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var name: String
    var days: [Day]
    
    var today: Day? {
        get {
            
            for day in days {
                
                let date = Date(timeIntervalSince1970: day.date)
                
                if Calendar.current.isDateInToday(date) {
                    return day
                }
            }
            
            return nil
        }
    }
    
    var tomorrow: Day? {
        
        get {
            
            for day in days {
                
                let date = Date(timeIntervalSince1970: day.date)
                
                if Calendar.current.isDateInTomorrow(date) {
                    return day
                }
            }
            
            return nil
        }
    }
    
    init(name: String) {
        self.name = name
        days = [Day]()
        days.append(Day(daysFromNow: 0))
        days.append(Day(daysFromNow: 1))
    }
    
    func transform() -> [String: Any] {
        var dict: [String: Any] = [String: Any]()
        
        dict["name"] = name
        
        var daysDict = [String: Any]()
        
        for (index,day) in days.enumerated() {
            daysDict["\(index)"] = day.transform()
        }
        
        dict["days"] = daysDict
        
        return dict
    }
    
    mutating func createDayFrom(now: Int) {
        days.append(Day(daysFromNow: now))
    }
        
}
