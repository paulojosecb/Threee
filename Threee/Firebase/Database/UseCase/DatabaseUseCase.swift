//
//  DatabaseUseCase.swift
//  Threee
//
//  Created by Paulo José on 28/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

class DatabaseUseCase {
    private let gateway: DatabaseGateway
    private let presenter: DatabasePresenter
    
    init(gateway: DatabaseGateway, presenter: DatabasePresenter) {
        self.gateway = gateway
        self.presenter = presenter
    }
    
    func fetchUser(uid: String) {
        gateway.fetchUser(uid: uid, completion: presentFetchResult(result:))
    }
    
    func update(user: User, with uid: String) {
        gateway.update(user: user, with: uid, completion: presentUserUpdateResult(result:))
    }
    
    func update(day: Day, with uid: String) {
        gateway.update(day: day, with: uid)
    }
    
    func observerDay(with uid: String) {
        gateway.observerDay(with: uid, completion: presentObserverResult(result:))
    }
    
    private func presentFetchResult(result: FetchResult) {
        switch result {
        case let .success(user): self.presenter.fetchUserSucess(user)
        case let .failure(Error): self.presenter.failure(Error)
        }
    }
    
    private func presentObserverResult(result: DayObserverResult) {
        switch result {
        case let .sucess(day): self.presenter.observeredDay(day)
        case let .failure(error): self.presenter.failure(error)
        }
    }
    
    private func presentUserUpdateResult(result: UserUpdateResult) {
        switch result {
        case .sucess(_): self.presenter.updateUserSucess()
        case let .failure(error): self.presenter.failure(error)
        }
    }
    
//    private func presentUpdateDayResult(result: ) {
//        switch result {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
//    }
}
