//
//  ItemType+CoreDataProperties.swift
//  WishList
//
//  Created by LI MENG on 2017-05-30.
//  Copyright © 2017 LI MENG. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
