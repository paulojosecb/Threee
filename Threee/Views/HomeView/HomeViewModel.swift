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
    
    init(delegate: HomeViewModelDelegate, mode: DayMode) {
        self.delegate = delegate
        self.mode = mode
    }
    
    func signOut() {

    }
        
}

extension HomeViewModel : ItemFieldViewDelegate {
    
    func toggleItem(on index: Int) {
        guard let day = day, let _ = dayIndex else { return }
        day.toggle(item: index)
//        database.update(day: day, with: "\(dayIndex)")
    }
    
}

extension HomeViewModel : InputModalViewDelegate {
    
    func createItemWith(name: String) {
        guard let day = day, let _ = dayIndex else { return }
        day.add(item: Item(name: name))
//        database.update(day: day, with: "\(dayIndex)")
    }
    
    func editItemWith(name: String, on index: Int) {
        guard let day = day, let _ = dayIndex else { return }
        day.edit(item: index, newValue: name)
//        database.update(day: day, with: "\(dayIndex)")
    }
    
}
