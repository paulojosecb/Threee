//
//  ItemTests.swift
//  ThreeeTests
//
//  Created by Paulo José on 28/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import XCTest
@testable import Threee

class ItemTests: XCTestCase {

    func testTransform() {
        var item = Item()
        let dict: [String: Any] = ["name": "", "checked": false]
        
        let transformedItem = NSDictionary(dictionary: item.transform())
        
        XCTAssertNotNil(item.transform())
        XCTAssert(transformedItem.isEqual(to: dict))
        
    }

}
