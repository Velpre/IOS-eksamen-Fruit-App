class FruitDataBrain{

    //Data fetched when FruitListVC is loaded
    static var fruits = [Fruit]()
    
    func getAllUniqFamiles() -> [String]? {
        let array = FruitDataBrain.fruits.map { obj in
            return obj.family
        }
        
        let families = Set(array)
        let arrayToReturn = Array(families)

        return arrayToReturn
    }
    
    func getAllUniqOrder() -> [String]? {
        let array = FruitDataBrain.fruits.map { obj in
            return obj.order
        }
        
        let orders = Set(array)
        let arrayToReturn = Array(orders)

        return arrayToReturn
    }
    
    func getAllUniqGenus() -> [String]? {
        let array = FruitDataBrain.fruits.map { obj in
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
    
}
