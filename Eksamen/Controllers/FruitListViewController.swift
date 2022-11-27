
import UIKit

class FruitListViewController: UIViewController {
    
    var apiManager = ApiManager()
    var colorManager = ColorManager()
    
    var fruitList = [Fruit]()
    //This string is dynamic updated when accessing this ViewController from Fruit Group ViewController
    var urlString = "https://www.fruityvice.com/api/fruit/all"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadFruitsFromServer()
    }
    
    func loadFruitsFromServer (){
        apiManager.getAllFruits(url: urlString){error, result in
            if let error = error {
                let message = error.localizedDescription
                DispatchQueue.main.async {
                    self.showAlertWith(message: message)
                }
            }
            
            if let fruitArray = result {
                self.fruitList = fruitArray.sorted(by: { object1, object2 in
                    return object1.id < object2.id
                })
            }
        
            DispatchQueue.main.async {
         
                self.tableView.reloadData()
                //Kaller på methoden som angir randome farger
                self.colorManager.addColorToFamilies(fruitArray: self.fruitList)
                //Sender data til dataBrain klassen
                DataBrain.fruits = self.fruitList
            }
        }
    }
    
    func showDetail(fruit:Fruit) {
        let detailVC = self.storyboard?.instantiateViewController(identifier: "FruitDetailViewController") as! FruitDetailViewController
        detailVC.fruit = fruit
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}


extension FruitListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruitList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FruitListTableViewCell") as! FruitListTableViewCell
        let fruit = fruitList[indexPath.row]
        cell.fruitName.text = fruit.name
        cell.fruitImage?.backgroundColor = colorManager.getColorForFamily(family: fruit.family)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fruit = fruitList[indexPath.row]
        self.showDetail(fruit: fruit)
    }
}

