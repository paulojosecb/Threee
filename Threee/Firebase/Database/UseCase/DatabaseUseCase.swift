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
}
