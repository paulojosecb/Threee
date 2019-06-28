//
//  DayTests.swift
//  ThreeeTests
//
//  Created by Paulo José on 28/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import XCTest
@testable import Threee

class DayTests: XCTestCase {

    func testIsDayComplete() {
        var day = Day(daysFromNow: 0)
        
        day.items[0].checked = true
        day.items[1].checked = true
        day.items[2].checked = true
        
        XCTAssertTrue(day.isDayCompleted())
        
        day.items[0].checked = false
        XCTAssertFalse(day.isDayCompleted())
    }
    
    func testToggleItem() {
        var day = Day(daysFromNow: 0)
        
        let initialItemCheckValue = day.items[0].checked
        
        day.toggle(item: 0)
        
        XCTAssertNotEqual(initialItemCheckValue, day.items[0].checked)
        XCTAssertTrue(day.items[0].checked)
        
        day.toggle(item: 0)
        
        XCTAssertFalse(day.items[0].checked)
    }
    
    func testEditItem() {
        var day = Day(daysFromNow: 0)
        let newValue = "Olá, mundo dos testes"
        
        day.edit(item: 0, newValue: newValue)
        
        XCTAssertEqual(day.items[0].name, newValue)
    }
    
    
    func testTransform() {
        var day = Day(daysFromNow: 0)
        
        let dict : [String: Any] = ["date": day.date,
                                    "items": [
                                                "0": day.items[0].transform(),
                                                "1": day.items[1].transform(),
                                                "2": day.items[2].transform()
        ]]
        
        let transformedDict = NSDictionary(dictionary: dict)
        
        XCTAssertNotNil(day.transform())
        XCTAssertTrue(transformedDict.isEqual(to: day.transform()))
    }
    
    

}
