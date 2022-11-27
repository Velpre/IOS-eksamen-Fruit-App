import Foundation
import CoreData


extension EatenFruitList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EatenFruitList> {
        return NSFetchRequest<EatenFruitList>(entityName: "EatenFruitList")
    }
    
    @NSManaged public var protein: String?
    @NSManaged public var sugar: String?
    @NSManaged public var name: String?
    @NSManaged public var fat: String?
    @NSManaged public var date: String?
    @NSManaged public var carbohydrates: String?
    @NSManaged public var calories: String?


}

extension EatenFruitList : Identifiable {

}
