
import UIKit
class LogViewController: UIViewController {
    var data = [String?: [EatenFruitList]]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var nutritionsResult = [[String]]()

    
    @IBOutlet weak var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.rowHeight = 44;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async { [self] in
            self.getAllEatenFruitFromCoreData()
            calculateNutritions()
            tableView.reloadData()
            if data.count == 0 {
                showAlertWith(message: "Du har ikke spist frukt ennå", title: "Info")
            }
        }
        nutritionsResult = []
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        //reseting all nutrition properties
        protein = 0.0
    }
    
    func getAllEatenFruitFromCoreData(){
        do{
            let model = try context.fetch(EatenFruitList.fetchRequest())
            data = Dictionary(grouping: model, by: {$0.date})
        }
        catch{
            showAlertWith(message: "Problem med CoreData", title: "Info")
        }
    }
    
    

    var calories: Float = 0.0
    var carb: Float = 0.0
    var fat: Float = 0.0
    var protein: Float = 0.0
    var sugar: Float = 0.0
    
    func resetNutritions(){
        calories = 0.0
        carb = 0.0
        fat = 0.0
        protein = 0.0
        sugar = 0.0
    }

    func calculateNutritions(){

        for(key, value) in data {
          
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
}


extension LogViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(data)[section].key
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(data)[section].value.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EatenFruitTableViewCell") as! EatenFruitTableViewCell
        let fruit = Array(data)[indexPath.section].value[indexPath.row].name
        
        cell.eatenFruitName.text = fruit
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FooterCell") as! FooterCell
        cell.eatenFruitFooter.text = "Calories:\(nutritionsResult[section][0]) Carb:\(nutritionsResult[section][1]) Fat:\(nutritionsResult[section][2]) Protein:\(nutritionsResult[section][3])  Sugar:\(nutritionsResult[section][4])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}




