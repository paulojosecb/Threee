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

typealias FetchResult = FetchResultEnum<User, Error>

protocol DatabaseGateway {
    func fetchUser(uid: String, completion: @escaping (FetchResult) -> Void)
}
