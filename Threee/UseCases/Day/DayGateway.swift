//
//  DayGateway.swift
//  Threee
//
//  Created by Paulo José on 20/10/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

protocol DayGateway {
    func create(day: Day) throws -> Day
    func getDays(completion: @escaping (([Day]) -> Void)) throws
    func update(day: Day, completion: ((Day) -> Void)) throws 
}
