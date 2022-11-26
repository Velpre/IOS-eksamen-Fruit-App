import Foundation

struct Fruit:Codable {
    var genus:String
    var name:String
    var id:Int
    var family:String
    var order:String
    var nutritions:Nutritions
}

struct EatenFruit{
    var name:String
    //var nutritions:Nutritions
    var date: String
}

struct Nutritions:Codable {
    var carbohydrates:Float
    var protein:Float
    var fat:Float
    var calories:Float
    var sugar:Float
}

enum CellType:String {
    case name
    case family
    case order
    case carbohydrates
    case protein
    case fat
    case calories
    case sugar
    case genus
    case id
}
