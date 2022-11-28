
import UIKit
class LogViewController: UIViewController {
    var dataBrain = EatenFruitDataBrain()
    var data = [String?: [EatenFruitList]]()
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
            data = dataBrain.getEatenFruitGroupedByDate()
            nutritionsResult = dataBrain.getNutritions()
            tableView.reloadData()
            if data.count == 0 {
                showAlertWith(message: "Du har ikke spist frukt ennå", title: "Info")
            }
        }
        nutritionsResult = []
        dataBrain.nutritionsResult = []
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
        cell.eatenFruitFooter.text = "Calories:\(nutritionsResult[section][0])     Carb:\(nutritionsResult[section][1])     Fat:\(nutritionsResult[section][2])     Protein:\(nutritionsResult[section][3])     Sugar:\(nutritionsResult[section][4])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}




