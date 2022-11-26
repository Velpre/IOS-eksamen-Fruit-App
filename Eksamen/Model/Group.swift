import Foundation

enum SectionType{
    case family
    case order
    case genus
}

struct SectionData {
    var title:String
    var list:[String]
    var sectionType:SectionType
}
