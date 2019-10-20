//
//  CoreDataGateway.swift
//  Threee
//
//  Created by Paulo José on 20/10/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation
import CoreData

class CoreDataGateway: DayGateway {
    private let modelName: String
    
    lazy var managedContext: NSManagedObjectContext = { return self.storeContainer.viewContext
    }()
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)") }
        }
        return container
    }()
    
    func create(day: Day) throws -> Day {
        let dayCore = DayCore(context: managedContext)
        dayCore.id = day.id
        dayCore.date = day.date
        
        guard let items = day.items else {
            throw CustomError(message: "Error")
        }
        
        for item in items {
            let itemCore = ItemCore(context: managedContext)
            itemCore.name = item.name
            itemCore.checked = item.checked
            
            dayCore.addToItems(itemCore)
        }
        
        do {
            try self.managedContext.save()
            return day
        } catch let error {
            throw error
        }
    }
    
    func getDays(completion: @escaping (([Day]) -> Void)) throws {
        do {
            let fetchRequest = NSFetchRequest<DayCore>(entityName: "DayCore")
            
            let daysCore = try managedContext.fetch(fetchRequest)
            
            var days: [Day] = []
            
            for dayCore in daysCore {
                let day = Day(daysFromNow: 0)
                day.date = dayCore.date!
                day.items = []
                day.id = dayCore.id!
                
                guard let itemsCores = dayCore.items?.array as? [ItemCore] else {
                    days.append(day)
                    return
                }
                
                day.items = self.convertCoreData(itemsCore: itemsCores)
                days.append(day)
            }
            
            completion(days)
            
        } catch let error {
            throw error
        }
    }
    
    func update(day: Day, completion: ((Day) -> Void)) throws {
        do {
            let fetchRequest = NSFetchRequest<DayCore>(entityName: "DayCore")
            let daysCore = try managedContext.fetch(fetchRequest)
            
            let dayCoreToUpdate = daysCore.first { (dayCore) -> Bool in
                dayCore.id == day.id
            }
            
            dayCoreToUpdate?.date = day.date
            dayCoreToUpdate?.id = day.id
            
            guard let items = day.items else {
                try managedContext.save()
                return
            }
                        
            for (index, item) in items.enumerated() {
                let itemCore = ItemCore(context: managedContext)
                itemCore.name = item.name
                itemCore.checked = item.checked
                
                guard let count = dayCoreToUpdate?.items?.count else {
                    break
                }
                
                if (index < count) {
                    dayCoreToUpdate?.replaceItems(at: index, with: itemCore)
                } else {
                    dayCoreToUpdate?.addToItems(itemCore)
                }
            }
            
            try managedContext.save()
            completion(day)
        } catch let error {
            throw error
        }
    }
    
    func convertCoreData(itemsCore: [ItemCore]) -> [Item] {
        var items: [Item] = []
        
        for itemCore in itemsCore {
            let item = Item(name: itemCore.name!)
            item.checked = itemCore.checked
            items.append(item)
        }
        
        return items
    }
}
