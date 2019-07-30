//
//  DatabasePresenter.swift
//  Threee
//
//  Created by Paulo José on 28/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

protocol DatabasePresenter {
    func fetchUserSucess(_ user: User)
    func failure(_ error: Error)
    func observeredDay(_ day: Day)
    func updateUserSucess()
}
