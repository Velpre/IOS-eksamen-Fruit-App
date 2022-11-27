import Foundation
import UIKit

class ColorManager{
    
    var colorDict = [String:UIColor]()
    var colors = [UIColor]()

    
    func getColorForFamily(family:String) -> UIColor {
        return colorDict[family] ?? UIColor.clear
    }
    
    func addColorToFamilies(fruitArray fruitListAll: [Fruit]){
        let families = getAllUniqFamiles(fruitList: fruitListAll)
    
            for family in families {
                if let _ = colorDict[family] {
                    // color is already present for the family
                } else {
                    while true {
                        let newColor:UIColor = .random
                        if let _ = colors.firstIndex(where: { color in
                            return color == newColor
                        }) {
                            print("color is already there \(newColor)")
                        } else {
                            colorDict[family] = newColor
                            colors.append(newColor)
                            break
                        }
                    }
                }
            }
    }
    
    func getAllUniqFamiles(fruitList: [Fruit]) -> [String] {
        let array = fruitList.map { obj in
            return obj.family
        }
        let families = Set(array)
        let arrayToReturn = Array(families)
        return arrayToReturn
    }
}

