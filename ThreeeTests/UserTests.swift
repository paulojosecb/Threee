//
//  UserTests.swift
//  ThreeeTests
//
//  Created by Paulo José on 28/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import XCTest
@testable import Threee

class UserTests: XCTestCase {
    
    func testToday() {
        let user = User(name: "Paulo")
        let userDate = Date(timeIntervalSince1970: user.today.date)
        XCTAssertTrue(Calendar.current.isDateInToday(userDate))
    }
    
    func testTomorrow() {
        var user = User(name: "Paulo")
        let userDate = Date(timeIntervalSince1970: user.tomorrow.date)
        XCTAssertTrue(Calendar.current.isDateInTomorrow(userDate))
    }
    
    func testTransform() {
        let user = User(name: "Paulo")
        
        let dict : [String : Any] = ["name": user.name, "days": ["0": user.days[0].transform(), "1": user.days[1].transform()]]
        
        let transformedDict = NSDictionary(dictionary: dict)
        
        XCTAssertNotNil(user.transform())
        XCTAssertTrue(transformedDict.isEqual(to: user.transform()))
    }

}
