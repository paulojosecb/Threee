//
//  HomeViewModel.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    let delegate: HomeViewModelDelegate
    var database: DatabaseUseCase?
    
    init(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    func initializeDatabase() {
        let gateway = DatabaseGatewayFirebase(database: FirebaseCoordinator.shared.databaseReference)
        database = DatabaseUseCase(gateway: gateway, presenter: self)
    }
    
    func observerToday() {
        if database == nil {
            initializeDatabase()
        }
        
        guard let database = database,
              let currentUser = FirebaseCoordinator.shared.auth.currentUser else { return }
        
        database.fetchUser(uid: currentUser.uid)
    }
    
}

extension HomeViewModel: DatabasePresenter {
    func observeredDay(_ day: Day) {
        delegate.didUpdate(day: day)
    }
    
    func fetchUserSucess(_ user: User) {
        guard let database = database else { return }
        guard let today = user.days.firstIndex(of: user.today) else { return }
        
        database.observerDay(with: "\(today)")
    }
    
    func failure(_ error: Error) {
        delegate.didReceivedError(error: error)
    }
}
