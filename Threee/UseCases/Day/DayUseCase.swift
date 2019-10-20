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
        do {
            try gateway.getDays { (days) in
                print(days.count)
                for day in days {
                    
                    let date = day.date
                    
                    if Calendar.current.isDateInToday(date) {
                        completion(.sucess([day]))
                        return
                    }
                }
                
                self.createDay(from: 0, completion: completion)
            }
            
        } catch let error {
            completion(.failure(error))
        }
        
    }
    
    func getTomorrow(completion: @escaping (DayUseCaseResult<Day>) -> Void) {
        do {
            try gateway.getDays { (days) in
                for day in days {
                    
                    let date = day.date
                    
                    if Calendar.current.isDateInTomorrow(date) {
                        completion(.sucess([day]))
                        return
                    }
                }
                
                self.createDay(from: 1, completion: completion)
                
            }

        } catch let error {
            completion(.failure(error))
        }
    }
    
    func update(day: Day, completion: (DayUseCaseResult<Day>) -> Void) {
        do {
            try gateway.update(day: day) { (day) in
                completion(.sucess([day]))
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    private func createDay(from: Int, completion:  @escaping (DayUseCaseResult<Day>) -> Void) {
        do {
            let day = Day(daysFromNow: from)
            let dayToReturn = try gateway.create(day: day)
            completion(.sucess([dayToReturn]))
        } catch let error {
            completion(.failure(error))
        }
    }
    
}
