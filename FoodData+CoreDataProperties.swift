//
//  FoodData+CoreDataProperties.swift
//  myApri
//
//  Created by MacUser on 2017/07/03.
//  Copyright © 2017年 Yuka Saito. All rights reserved.
//

import Foundation
import CoreData


extension FoodData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodData> {
        return NSFetchRequest<FoodData>(entityName: "FoodData")
    }

    @NSManaged public var buyDate: NSDate?
    @NSManaged public var charge: String?
    @NSManaged public var dose: String?
    @NSManaged public var limitDate: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var btn1: String?
    @NSManaged public var btn: String?
    @NSManaged public var btn2: String?

}
