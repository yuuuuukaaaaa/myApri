//
//  BuyData+CoreDataProperties.swift
//  myApri
//
//  Created by MacUser on 2017/07/19.
//  Copyright © 2017年 Yuka Saito. All rights reserved.
//

import Foundation
import CoreData


extension BuyData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BuyData> {
        return NSFetchRequest<BuyData>(entityName: "BuyData")
    }

    @NSManaged public var dose: String?
    @NSManaged public var name: String?

}
