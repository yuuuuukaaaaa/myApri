//
//  BuyData+CoreDataProperties.swift
//  myApri
//
//  Created by MacUser on 2017/06/30.
//  Copyright © 2017年 Yuka Saito. All rights reserved.
//

import Foundation
import CoreData


extension BuyData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BuyData> {
        return NSFetchRequest<BuyData>(entityName: "BuyData")
    }

    @NSManaged public var name: String?
    @NSManaged public var dose: String?

}
