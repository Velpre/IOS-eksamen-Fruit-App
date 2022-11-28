import UIKit

class EatenFruitDataBrain: UIViewController{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    var data = [String?: [EatenFruitList]]()
    var model = [EatenFruitList]()
    var nutritionsResult = [[String]]()
    
    var calories: Float = 0.0
    var carb: Float = 0.0
    var fat: Float = 0.0
    var protein: Float = 0.0
    var sugar: Float = 0.0
    
    var numberOfFruitEatenlast30Days = 0

    func saveEatenFruitToCoreData(name: String, date: String, protein: String, carbohydrates: String, fat: String, calories: String, sugar: String){
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
            showAlertWith(message: "Problem med lagring i CoreData")
        }
    }
    
    func fetchEatenFruitFromCoreData(){
        do{
            model = try context.fetch(EatenFruitList.fetchRequest())
            data = Dictionary(grouping: model, by: {$0.date})
        }
        catch{
            showAlertWith(message: "Problem med CoreData", title: "Info")
        }
    }
    
    func calculateNutritions(){
        for(_, value) in data {
            for (e) in value{
                if let e = e.calories{
                    calories += Float(e)!
                }
                if let e = e.carbohydrates{
                    carb += Float(e)!
                }
                if let e = e.fat{
                    fat += Float(e)!
                }
                if let e = e.protein{
                    protein += Float(e)!
                }
                if let e = e.sugar{
                    sugar += Float(e)!
                }
            }
            nutritionsResult.append([
                String(format: "%.1f", calories),
                String(format: "%.1f", carb),
                String(format: "%.1f", fat),
                String(format: "%.1f", protein),
                String(format: "%.1f", sugar)
            ])
            resetNutritions()
        }
    }
    
    func resetNutritions(){
        calories = 0.0
        carb = 0.0
        fat = 0.0
        protein = 0.0
        sugar = 0.0
    }

    
    func getNutritions() -> [[String]]{
        calculateNutritions()
        return nutritionsResult
    }
    
    
    func getEatenFruitGroupedByDate()->[String?: [EatenFruitList]]{
        fetchEatenFruitFromCoreData()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        
        return data
    }
    
    func getEatenFruit()->[EatenFruitList]{
        fetchEatenFruitFromCoreData()
        return model
    }
    
    
    func fromStringToDate(date:String)->Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.date(from: date)!
    }
    
    func calculateNumberOfFruitEatenLast30Days(fruitName: String) -> Int{
        numberOfFruitEatenlast30Days = 0
        let allFruits: [EatenFruitList] = getEatenFruit()
        let currentDate = Date()
        let thirtyDaysBefore = Calendar.current.date(byAdding: .day, value: -30, to: currentDate)
        
        for eatenFruit in allFruits {
            if eatenFruit.name == fruitName{
                let fruitDate = fromStringToDate(date:eatenFruit.date!)
                if thirtyDaysBefore! < fruitDate{
                    numberOfFruitEatenlast30Days += 1
                }
            }
        }
        return numberOfFruitEatenlast30Days
    }
}
