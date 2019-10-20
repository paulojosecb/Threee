//
//  DayUseCaseMockGateway.swift
//  ThreeeTests
//
//  Created by Paulo José on 20/10/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation
@testable import Threee

class DayUseCaseMockGateway: DayGateway {
    
    var days: [Day]
    var isErrorMock: Bool
    
    init(isErrorMock: Bool) {
        self.days = []
        self.isErrorMock = isErrorMock
    }
    
    func create(day: Day) throws -> Day {
        if (isErrorMock) {
            throw CustomError(message: "Error")
        }
        self.days.append(day)
        return day
    }
    
    func getDays(completion: @escaping (([Day]) -> Void)) throws {
        if (isErrorMock) {
            throw CustomError(message: "Error")
        }
        completion((self.days))
    }
    
    func update(day: Day, completion: ((Day) -> Void)) throws {
        if (isErrorMock) {
            throw CustomError(message: "Error")
        }
        
        guard let indexToUpdate = self.days.firstIndex(of: day) else {
            return
        }
        self.days.remove(at: indexToUpdate)
        self.days.insert(day, at: indexToUpdate)
    }
    
    
}
