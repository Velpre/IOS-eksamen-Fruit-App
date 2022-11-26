
import UIKit

class EatFruitViewController: UIViewController {
    
    var fruit:Fruit!
    let datePicker = UIDatePicker()
        
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
            let eatenFruit = EatenFruit(name: safeFruit.name, date: formatedDate)
            DataBrain.eatenFruit.append(eatenFruit)
        }
        
        let listFruitVC = self.storyboard?.instantiateViewController(identifier: "FruitListViewController") as! FruitListViewController
        self.navigationController?.pushViewController(listFruitVC, animated: true)
    }
    
    @IBAction func cancelEatFruitPressed(_ sender: UIButton) {
        let detailVC = self.storyboard?.instantiateViewController(identifier: "FruitDetailViewController") as! FruitDetailViewController
        detailVC.fruit = fruit
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
