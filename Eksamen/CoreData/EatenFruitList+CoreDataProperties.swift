//
//  EatenFruitList+CoreDataProperties.swift
//  Eksamen
//
//  Created by VP on 26/11/2022.
//
//

import Foundation
import CoreData


extension EatenFruitList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EatenFruitList> {
        return NSFetchRequest<EatenFruitList>(entityName: "EatenFruitList")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: String?
    @NSManaged public var protein: String?
    @NSManaged public var carbohydrates: String?
    @NSManaged public var fat: String?
    @NSManaged public var calories: String?
    @NSManaged public var sugar: String?

}

extension EatenFruitList : Identifiable {

}
