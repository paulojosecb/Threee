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
    let useCase: DayUseCase?
    
    var mode: DayMode
    
    let delegate: HomeViewModelDelegate
    
    init(delegate: HomeViewModelDelegate, mode: DayMode) {
        self.useCase = DayUseCase(gateway: CoreDataGateway(modelName: "ThreeeModel"))
        self.delegate = delegate
        self.mode = mode
        
        
        if (mode == .today) {
            useCase?.getToday(completion: { (result) in
                switch result {
                case let .sucess(days):
                    guard let today = days?.first else { return }
                    self.day = today
                case let .failure(error):
                    delegate.didReceivedError(error: error ?? CustomError(message: "an error has occurred"))
                }
            })
        } else {
            useCase?.getTomorrow(completion: { (result) in
                switch result {
                case let .sucess(days):
                    guard let tomorrow = days?.first else { return }
                    self.day = tomorrow
                case let .failure(error):
                    delegate.didReceivedError(error: error ?? CustomError(message: "an error has occurred"))
                }
            })
        }
    }
    
    func update() {
        
        guard let useCase = useCase, let day = day else {
            return
        }
        
        useCase.update(day: day) { (result) in
            switch result {
            case let .sucess(days):
                
                guard let day = days?.first else {
                    return
                }
                
                self.day = day
                
                delegate.didUpdate(day: day)
            case let .failure(error):
                delegate.didReceivedError(error: error ?? CustomError(message: "An error has happened"))
            }
        }
    }
        
}

extension HomeViewModel : ItemFieldViewDelegate {
    
    func toggleItem(on index: Int) {
        guard let day = day else { return }
        day.toggle(item: index)
        
        self.update()
    }
    
}

extension HomeViewModel : InputModalViewDelegate {
    
    func createItemWith(name: String) {
        guard let day = day else { return }
        day.add(Item(name: name))
        self.update()
    }
    
    func editItemWith(name: String, on index: Int) {
        guard let day = day else { return }
        day.edit(item: index, newValue: name)
        
        self.update()
    }
    
}
