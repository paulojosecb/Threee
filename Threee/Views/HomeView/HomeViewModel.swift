//
//  HomeViewModel.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    var today: Day?
    var todayIndex: Int?
    
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
        today = day
        delegate.didUpdate(day: day)
    }
    
    func fetchUserSucess(_ user: User) {
        guard let database = database else { return }
        guard let today = user.days.firstIndex(of: user.today) else { return }
        
        todayIndex = today
        
        database.observerDay(with: "\(today)")
    }
    
    func failure(_ error: Error) {
        print(error.localizedDescription)
        delegate.didReceivedError(error: error)
    }
}

extension HomeViewModel : ItemFieldViewDelegate {
    
    func toggleItem(on index: Int) {
        guard let today = today, let todayIndex = todayIndex, let database = database else { return }
        today.toggle(item: index)
        database.update(day: today, with: "\(todayIndex)")
    }
    
}

extension HomeViewModel : InputModalViewDelegate {
    
    func createItemWith(name: String) {
        guard let today = today, let todayIndex = todayIndex, let database = database else { return }
        today.add(item: Item(name: name))
        database.update(day: today, with: "\(todayIndex)")
    }
    
    func editItemWith(name: String, on index: Int) {
        guard let today = today, let todayIndex = todayIndex, let database = database else { return }
        today.edit(item: index, newValue: name)
        database.update(day: today, with: "\(todayIndex)")
    }
    
}
