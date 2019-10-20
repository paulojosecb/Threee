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
        
        day.add(Item(name: "Olá"))
        day.add(Item(name: "Olá"))
        day.add(Item(name: "Olá"))
        
        guard let items = day.items else {
            XCTFail()
            return
        }
        
        items[0].checked = true
        items[1].checked = true
        items[2].checked = true
        
        XCTAssertTrue(day.isDayCompleted())
        
        items[0].checked = false
        XCTAssertFalse(day.isDayCompleted())
    }
    
    func testToggleItem() {
        var day = Day(daysFromNow: 0)
        
        day.add(Item(name: "Olá"))
        day.add(Item(name: "Olá"))
        day.add(Item(name: "Olá"))
        
        guard let items = day.items else {
            XCTFail()
            return
        }
        
        let initialItemCheckValue = items[0].checked
        
        day.toggle(item: 0)
        
        XCTAssertNotEqual(initialItemCheckValue, items[0].checked)
        XCTAssertTrue(items[0].checked)
        
        day.toggle(item: 0)
        
        XCTAssertFalse(items[0].checked)
    }
    
    func testEditItem() {
        var day = Day(daysFromNow: 0)
        
        day.add(Item(name: "Olá"))
        day.add(Item(name: "Olá"))
        day.add(Item(name: "Olá"))
        
        let newValue = "Olá, mundo dos testes"
        
        guard let items = day.items else {
            XCTFail()
            return
        }
        
        day.edit(item: 0, newValue: newValue)
        
        XCTAssertEqual(items[0].name, newValue)
    }
    
    
//    func testTransform() {
//        var day = Day(daysFromNow: 0)
//
//        let dict : [String: Any] = ["date": day.date,
//                                    "items": [
//                                                "0": day.items[0].transform(),
//                                                "1": day.items[1].transform(),
//                                                "2": day.items[2].transform()
//        ]]
//
//        let transformedDict = NSDictionary(dictionary: dict)
//
//        XCTAssertNotNil(day.transform())
//        XCTAssertTrue(transformedDict.isEqual(to: day.transform()))
//    }
    
    

}
