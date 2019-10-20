//
//  DayUseCase.swift
//  Threee
//
//  Created by Paulo José on 20/10/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

enum DayUseCaseResult<Day> {
    case sucess([Day]?)
    case failure(Error)
}

class DayUseCase {
    
    private let gateway: DayGateway
    
    init(gateway: DayGateway) {
        self.gateway = gateway
    }
    
    func getToday(completion: (DayUseCaseResult<Day>) -> Void) {
        gateway.getDays { (days) in
            completion(.sucess(days))
        }
    }
    
    func getTomorrow(completion: (DayUseCaseResult<Day>) -> Void) {
        gateway.getDays { (days) in
            completion(.sucess(days))
        }
    }
    
    func update(day: Day, completion: (DayUseCaseResult<Day>) -> Void) {
        gateway.update(day: day) { (day) in
            completion(.sucess([day]))
        }
    }
    
}
