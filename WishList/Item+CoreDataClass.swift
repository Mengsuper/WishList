//
//  Item+CoreDataClass.swift
//  WishList
//
//  Created by LI MENG on 2017-05-30.
//  Copyright © 2017 LI MENG. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate() // set date
    }
}
