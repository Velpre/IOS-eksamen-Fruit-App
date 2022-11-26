import Foundation

class DataBrain{
    
    static var fruits = [Fruit]()
    
    static var eatenFruit = [EatenFruit]()
    static var dict = Dictionary(grouping: eatenFruit, by: {$0.date})

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
    
    
//    func ceckMaster(){
//
//        for (key, value) in dict {
//            print(key)
//            for e in value {
//                print(e.name)
//            }
//        }
//    }
 

    
    
//    eatenFruit = [{
//    name: "Apple",
//    date: 2022-11-25 19:21:33 +0000,
//    nutritions: {
//        carbohydrates: 11.4,
//        protein: 0.3,
//        fat: 0.4,
//        calories: 52.0,
//        sugar: 10.3
//    }
//
//}]
    
    


//    struct groupedEatenFruit:Codable{
//        var dato
//        var EatenFruit
//    }
}
