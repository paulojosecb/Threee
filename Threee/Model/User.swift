//
//  User.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var days: [Day]
    
    var today: Day {
        get {
            
            for day in days {
                
                let date = Date(timeIntervalSince1970: day.date)
                
                if Calendar.current.isDateInToday(date) {
                    return day
                }
            }
            
            return days[0]
        }
    }
    
    var tomorrow: Day {
        
        get {
            
            for day in days {
                
                let date = Date(timeIntervalSince1970: day.date)
                
                if Calendar.current.isDateInTomorrow(date) {
                    return day
                }
            }
            
            // If tomorrow is not created yet, it will create, append and return it
            let day = Day(daysFromNow: 1)
            days.append(day)
            return day
            
        }
    }
    
    init(name: String) {
        self.name = name
        days = [Day]()
        days.append(Day(daysFromNow: 0))
        days.append(Day(daysFromNow: 1))
    }
        
}
