//
//  ItemCore+CoreDataProperties.swift
//  
//
//  Created by Paulo José on 20/10/19.
//
//

import Foundation
import CoreData


extension ItemCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemCore> {
        return NSFetchRequest<ItemCore>(entityName: "ItemCore")
    }

    @NSManaged public var checked: Bool
    @NSManaged public var name: String?

}
