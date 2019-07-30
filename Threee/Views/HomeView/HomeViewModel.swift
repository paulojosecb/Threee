//
//  HomeViewModel.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

enum DayMode {
    case today
    case tomorrow
}

class HomeViewModel {
    
    var day: Day?
    var dayIndex: Int?
    
    var mode: DayMode
    
    let delegate: HomeViewModelDelegate
    var database: DatabaseUseCase?
    var auth: AuthUseCase?
    
    init(delegate: HomeViewModelDelegate, mode: DayMode) {
        self.delegate = delegate
        self.mode = mode
        self.fetchUser()
    }
    
    func initializeDatabase() {
        let gateway = DatabaseGatewayFirebase(database: FirebaseCoordinator.shared.databaseReference)
        database = DatabaseUseCase(gateway: gateway, presenter: self)
    }
    
    func initializeAuthUseCase() {
        let gateway = AuthGatewayFirebase(auth: FirebaseCoordinator.shared.auth)
        auth = AuthUseCase(gateway: gateway, presenter: self)
    }
    
    func signOut() {
        if (auth == nil) {
            initializeAuthUseCase()
        }
        
        guard let auth = auth else { return }
        
        auth.signOut()
    }
    
    func fetchUser() {
        if database == nil {
            initializeDatabase()
        }
        
        guard let database = database,
              let currentUser = FirebaseCoordinator.shared.auth.currentUser else { return }
        
        database.fetchUser(uid: currentUser.uid)
    }
    
    func update(user: User, with id: String) {
        
    }
    
}

extension HomeViewModel: DatabasePresenter {
    func observeredDay(_ day: Day) {
        self.day = day
        delegate.didUpdate(day: day)
    }
    
    func fetchUserSucess(_ user: User) {
        guard let database = database else { return }
        
        var mutableUser = user
    
        if (mode == .today) {
            
            let today = user.today
            
            if (today == nil) {
                
                mutableUser.createDayFrom(now: 0)
                
                guard let currentUser = FirebaseCoordinator.shared.auth.currentUser else { return }
                database.update(user: mutableUser, with: currentUser.uid)
                
            } else {
                
                guard let dayIndex = user.days.firstIndex(of: user.today!) else { return }
                self.dayIndex = dayIndex
                
                database.observerDay(with: "\(dayIndex)")

            }
            
        } else if (mode == .tomorrow) {
            
            let tomorrow = user.tomorrow
            
            if (tomorrow == nil) {
                
                mutableUser.createDayFrom(now: 1)
                
                guard let currentUser = FirebaseCoordinator.shared.auth.currentUser else { return }
                database.update(user: mutableUser, with: currentUser.uid)
                
            } else {
                
                guard let dayIndex = user.days.firstIndex(of: user.tomorrow!) else { return }
                self.dayIndex = dayIndex
                
                database.observerDay(with: "\(dayIndex)")
                
            }
            
        }
        
    }
    
    func updateUserSucess() {
        fetchUser()
    }
    
    func failure(_ error: Error) {
        print(error.localizedDescription)
        delegate.didReceivedError(error: error)
    }
}

extension HomeViewModel: AuthPresenter {
    func sucess(_ sucess: AuthSucess) {
        if (sucess == .signedOut) {
            delegate.didSignedOut()
        }
    }
    
    func failure(_ error: AuthError) {
        delegate.didReceivedError(error: error)
    }
    
    
}

extension HomeViewModel : ItemFieldViewDelegate {
    
    func toggleItem(on index: Int) {
        guard let day = day, let dayIndex = dayIndex, let database = database else { return }
        day.toggle(item: index)
        database.update(day: day, with: "\(dayIndex)")
    }
    
}

extension HomeViewModel : InputModalViewDelegate {
    
    func createItemWith(name: String) {
        guard let day = day, let dayIndex = dayIndex, let database = database else { return }
        day.add(item: Item(name: name))
        database.update(day: day, with: "\(dayIndex)")
    }
    
    func editItemWith(name: String, on index: Int) {
        guard let day = day, let dayIndex = dayIndex, let database = database else { return }
        day.edit(item: index, newValue: name)
        database.update(day: day, with: "\(dayIndex)")
    }
    
}
