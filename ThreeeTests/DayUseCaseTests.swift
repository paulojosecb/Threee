//
//  DayUseCaseTests.swift
//  ThreeeTests
//
//  Created by Paulo José on 20/10/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import XCTest
@testable import Threee

class DayUseCaseTests: XCTestCase {

    func testGetTodayWithoutError() {
        let useCase = DayUseCase(gateway: DayUseCaseMockGateway(isErrorMock: false))
        
        useCase.getToday { (result) in
            switch result {
            case let .sucess(days):
                guard let today = days?.first else {
                    XCTFail()
                    return
                }
                XCTAssertTrue(Calendar.current.isDateInToday(today.date))
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    func testGetTodayWithError() {
        let useCase = DayUseCase(gateway: DayUseCaseMockGateway(isErrorMock: true))
        
        useCase.getToday { (result) in
            switch result {
            case .failure(_):
                XCTAssertTrue(true)
            default:
                XCTFail()
            }
        }
        
    }
    
    func testGetTomorroWithoutError() {
        let useCase = DayUseCase(gateway: DayUseCaseMockGateway(isErrorMock: false))
        
        useCase.getTomorrow { (result) in
            switch result {
            case let .sucess(days):
                guard let tomorrow = days?.first else {
                    XCTFail()
                    return
                }
                XCTAssertTrue(Calendar.current.isDateInTomorrow(tomorrow.date))
            default:
                XCTFail()
            }
        }
    }
    
    func testGetTomorrowWithError() {
        let useCase = DayUseCase(gateway: DayUseCaseMockGateway(isErrorMock: true))
        
        useCase.getTomorrow { (result) in
            switch result {
            case .failure(_):
                XCTAssertTrue(true)
            default:
                XCTFail()
            }
        }
    }
    
    func testUpdateWithoutError() {
        let useCase = DayUseCase(gateway: DayUseCaseMockGateway(isErrorMock: false))
                
        useCase.getToday { (result) in
            switch result {
            case let .sucess(days):
                guard let today = days?.first else {
                    XCTFail()
                    return
                }
                
                today.add(Item(name: "Olá"))
                
                useCase.update(day: today) { (result) in
                    switch result {
                    case let .sucess(days):
                        guard let updatedToday = days?.first else {
                            XCTFail()
                            return
                        }
                        
                        XCTAssertTrue(updatedToday == today)
                    default:
                        XCTFail()
                    }
                }
                
            default:
                XCTFail()
            }
        }
    }
    
    func testUpdateWithError() {
        let useCase = DayUseCase(gateway: DayUseCaseMockGateway(isErrorMock: true))
        
        let day = Day(daysFromNow: 0)
        
        useCase.update(day: day) { (result) in
            switch result {
            case .failure(_):
                XCTAssertTrue(true)
            default:
                XCTFail()
            }
        }
    }

}
