
import UIKit




class LogViewController: UIViewController {
    var eatenFruit = [EatenFruit]()
    var data = [String: [EatenFruit]]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
        

    override func viewWillAppear(_ animated: Bool) {
        
        eatenFruit.append(EatenFruit(name: "fr1", date: "26.11.2022"))
        eatenFruit.append(EatenFruit(name: "fr2", date: "26.11.2022"))
        eatenFruit.append(EatenFruit(name: "fr3", date: "03.12.2022"))
        eatenFruit.append(EatenFruit(name: "fr4", date: "03.12.2022"))
        eatenFruit.append(EatenFruit(name: "fr5", date: "03.12.2022"))
        eatenFruit.append(EatenFruit(name: "fr6", date: "05.12.2022"))
        eatenFruit.append(EatenFruit(name: "fr7", date: "05.12.2022"))
        eatenFruit.append(EatenFruit(name: "test", date: "01.12.2022"))
        let dict = Dictionary(grouping: eatenFruit, by: {$0.date})
        data = dict
    }

}


extension LogViewController: UITableViewDataSource, UITableViewDelegate {
    
    //Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    //Header for evry section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(data)[section].key
    }
    
    //Number of rows in evry section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(data)[section].value.count
    }
 
    //Write to evry row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EatenFruitTableViewCell") as! EatenFruitTableViewCell
        let fruit = Array(data)[indexPath.section].value[indexPath.row].name
        
        cell.eatenFruitName.text = fruit
        cell.selectionStyle = .none
        return cell
    }
    

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
//        cell.headerName.text = "asdasd"
//        return cell
//    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        <#code#>
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        <#code#>
//    }
//
    
}




