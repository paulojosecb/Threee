//
//  DayCore+CoreDataProperties.swift
//  
//
//  Created by Paulo José on 20/10/19.
//
//

import Foundation
import CoreData


extension DayCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayCore> {
        return NSFetchRequest<DayCore>(entityName: "DayCore")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var items: NSOrderedSet?

}

// MARK: Generated accessors for items
extension DayCore {

    @objc(insertObject:inItemsAtIndex:)
    @NSManaged public func insertIntoItems(_ value: ItemCore, at idx: Int)

    @objc(removeObjectFromItemsAtIndex:)
    @NSManaged public func removeFromItems(at idx: Int)

    @objc(insertItems:atIndexes:)
    @NSManaged public func insertIntoItems(_ values: [ItemCore], at indexes: NSIndexSet)

    @objc(removeItemsAtIndexes:)
    @NSManaged public func removeFromItems(at indexes: NSIndexSet)

    @objc(replaceObjectInItemsAtIndex:withObject:)
    @NSManaged public func replaceItems(at idx: Int, with value: ItemCore)

    @objc(replaceItemsAtIndexes:withItems:)
    @NSManaged public func replaceItems(at indexes: NSIndexSet, with values: [ItemCore])

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: ItemCore)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: ItemCore)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSOrderedSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSOrderedSet)

}
