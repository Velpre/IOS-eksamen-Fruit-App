import Foundation
import CoreData
class DataBrain{
    
    static var fruits = [Fruit]()
    
    func getAllUniqFamiles() -> [String]? {
        let array = DataBrain.fruits.map { obj in
            return obj.family
        }
        
        let families = Set(array)
        let arrayToReturn = Array(families)

        return arrayToReturn
    }
    
    func getAllUniqOrder() -> [String]? {
        let array = DataBrain.fruits.map { obj in
            return obj.order
        }
        
        let orders = Set(array)
        let arrayToReturn = Array(orders)

        return arrayToReturn
    }
    
    func getAllUniqGenus() -> [String]? {
        let array = DataBrain.fruits.map { obj in
            return obj.genus
        }
        
        let genus = Set(array)
        let arrayToReturn = Array(genus)

        return arrayToReturn
    }
    
    func getGroupData() ->[SectionData]  {
        var arrayToReturn = [SectionData]()
        
        if let family = getAllUniqFamiles() {
            let sortedArray = family.sorted()
            let section = SectionData(title: "Family", list: sortedArray, sectionType: .family)
            arrayToReturn.append(section)
        }
        
        if let genus = getAllUniqGenus() {
            let sortedArray = genus.sorted()
            let section = SectionData(title: "Genus", list: sortedArray, sectionType: .genus)
            arrayToReturn.append(section)
        }
        
        if let order = getAllUniqOrder() {
            let sortedArray = order.sorted()
            let section = SectionData(title: "Order", list: sortedArray, sectionType: .order)
            arrayToReturn.append(section)
        }
        
        return arrayToReturn
    }
    
        
    func saveEatenFruitToCoreData(name: String, date: String, protein: String, carbohydrates: String, fat: String, calories: String, sugar: String, context: NSManagedObjectContext){
        let newItem = EatenFruitList(context: context)
        newItem.name = name
        newItem.date = date
        newItem.protein = protein
        newItem.fat = fat
        newItem.carbohydrates = carbohydrates
        newItem.calories = calories
        newItem.sugar = sugar
        do{
            try context.save()
        }
        catch{
            //showAlertWith(message: "Problem med lagring i CoreData")
        }
    }
    

}
