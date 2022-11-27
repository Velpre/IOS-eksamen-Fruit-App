
import UIKit

class EatFruitViewController: UIViewController {
    
    var fruit:Fruit!
    let datePicker = UIDatePicker()
    let dataBrain = EatenFruitDataBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        addDatePicker()
    }
    
    func addDatePicker(){
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = .current
        datePicker.minimumDate = Date()
        view.addSubview(datePicker)
        datePicker.center = view.center
    }


    func formatDate(date:Date) ->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }

    
    @IBAction func eatFruitPressed(_ sender: UIButton) {
        if let safeFruit = fruit{
            
            let formatedDate = formatDate(date:datePicker.date)
            print()
            
            let protein = String(safeFruit.nutritions.protein)
            let carbohydrates = String(safeFruit.nutritions.carbohydrates)
            let fat = String(safeFruit.nutritions.fat)
            let sugar = String(safeFruit.nutritions.sugar)
            let calories = String(safeFruit.nutritions.calories)

            dataBrain.saveEatenFruitToCoreData(name: safeFruit.name, date: formatedDate, protein: protein, carbohydrates: carbohydrates, fat: fat, calories: calories, sugar: sugar)
        }
        
        let  vc =  self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func cancelEatFruitPressed(_ sender: UIButton) {
        let detailVC = self.storyboard?.instantiateViewController(identifier: "FruitDetailViewController") as! FruitDetailViewController
        detailVC.fruit = fruit
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
