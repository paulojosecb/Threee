//
//  DayGateway.swift
//  Threee
//
//  Created by Paulo José on 20/10/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

protocol DayGateway {
    func getDays(completion: (([Day]) -> Void))
    func update(day: Day, completion: ((Day) -> Void)) -> Day
}
