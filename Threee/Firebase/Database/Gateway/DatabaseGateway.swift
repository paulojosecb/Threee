//
//  DatabaseGateway.swift
//  Threee
//
//  Created by Paulo José on 28/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

enum FetchResultEnum<User, Error> {
    case success(User)
    case failure(Error)
}

enum DayObserverResultEnum<Day, Errro> {
    case sucess(Day)
    case failure(Error)
}

enum UserUpdateResultEnum<User, Error> {
    case sucess(User)
    case failure(Error)
}

typealias FetchResult = FetchResultEnum<User, Error>
typealias DayObserverResult = DayObserverResultEnum<Day, Error>
typealias UserUpdateResult = UserUpdateResultEnum<User, Error>


protocol DatabaseGateway {
    func fetchUser(uid: String, completion: @escaping (FetchResult) -> Void)
    func observerDay(with uid: String, completion: @escaping (DayObserverResult) -> Void)
    func update(day: Day, with uid: String)
    func update(user: User, with uid: String, completion: @escaping (UserUpdateResult) -> Void)
}
