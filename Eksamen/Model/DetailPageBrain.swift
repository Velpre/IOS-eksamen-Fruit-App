//
//  DetailPageBrain.swift
//  Eksamen
//
//  Created by VP on 25/11/2022.
//

import Foundation

struct DetailPageBrain{
    var cellArray = [CellType]()
    
    
    mutating func updateDetailPageContent(cell: FruitDetailTableViewCell, indexPath: IndexPath, fruit: Fruit) -> FruitDetailTableViewCell{
        
        cellArray = [.name, .id, .family, .order, .genus, .carbohydrates, .protein, .fat, .calories, .sugar]
        
        print("daaa")

        let cellType = cellArray[indexPath.row]
        cell.selectionStyle = .none
        

        switch cellType {
        case .name:
            cell.elementName.text = "Name"
            cell.elementValue.text = fruit.name
            
        case .id:
            cell.elementName.text = "ID"
            cell.elementValue.text = "\(fruit.id)"
            
        case .family:
            cell.elementName.text = "Family"
            cell.elementValue.text = fruit.family
            
        case .order:
            cell.elementName.text = "Order"
            cell.elementValue.text = fruit.order
            
        case .genus:
            cell.elementName.text = "Genus"
            cell.elementValue.text = fruit.genus
            
        case .carbohydrates:
            cell.elementName.text = "Carbohydrates"
            cell.elementValue.text = "\(fruit.nutritions.carbohydrates )"
            
        case .protein:
            cell.elementName.text = "Protein"
            cell.elementValue.text = "\(fruit.nutritions.protein )"
            
        case .fat:
            cell.elementName.text = "Fat"
            cell.elementValue.text = "\(fruit.nutritions.fat )"
            
        case .calories:
            cell.elementName.text = "Calories"
            cell.elementValue.text = "\(fruit.nutritions.calories )"
            
        case .sugar:
            cell.elementName.text = "Sugar"
            cell.elementValue.text = "\(fruit.nutritions.sugar )"
        }
        
        return cell
        
        
    }
    
    func getCellArrayCount()->Int {
        return cellArray.count
    }
    
 
}
