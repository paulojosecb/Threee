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
    case failure(Error?)
}

class DayUseCase {
    
    private let gateway: DayGateway
    
    init(gateway: DayGateway) {
        self.gateway = gateway
    }
    
    func getToday(completion: @escaping (DayUseCaseResult<Day>) -> Void) {
        gateway.getDays { (days) in
            for day in days {
                
                let date = Date(timeIntervalSince1970: day.date)
                
                if Calendar.current.isDateInToday(date) {
                    completion(.sucess([day]))
                }
            }
            
            completion(.failure(nil))
        }
    }
    
    func getTomorrow(completion: @escaping (DayUseCaseResult<Day>) -> Void) {
        gateway.getDays { (days) in
            for day in days {
                
                let date = Date(timeIntervalSince1970: day.date)
                
                if Calendar.current.isDateInTomorrow(date) {
                    completion(.sucess([day]))
                }
            }
            
            completion(.failure(nil))
        }
    }
    
    func update(day: Day, completion: (DayUseCaseResult<Day>) -> Void) {
        gateway.update(day: day) { (day) in
            completion(.sucess([day]))
        }
    }
    
}
