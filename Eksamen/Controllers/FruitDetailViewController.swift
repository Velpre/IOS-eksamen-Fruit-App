import UIKit
import UIKit

class FruitDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var warningLabel: UILabel!
    
    var cellArray = [CellType]()
    var fruit:Fruit!
    var timer:Timer?
    var fruitAnimationColor:UIColor = .white

    
    override func viewDidLoad(){
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.title = fruit.name.capitalized
        cellArray = [.name, .id, .family, .order, .genus, .carbohydrates, .protein, .fat, .calories, .sugar]
        
        if fruit.nutritions.sugar > 10 {
            warningLabel.isHidden = false
            fireTimer()
        } else {
            warningLabel.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    func fireTimer(){
       timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector:  #selector(showBackgroundAnimation),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func showBackgroundAnimation(){
            if fruitAnimationColor == .white {
                fruitAnimationColor  = .red
            } else if fruitAnimationColor == .red {
                fruitAnimationColor  = .white
            }
        
        UIView.transition(with: self.view,
                          duration: 0.3,
                          animations: {
            self.view.backgroundColor = self.fruitAnimationColor
        },
        completion: nil)
    }
    
    
    
    @IBAction func eatFruitPressed(_ sender: UIButton) {
        let eatVC = self.storyboard?.instantiateViewController(identifier: "EatFruitViewController") as! EatFruitViewController
        eatVC.fruit = fruit
        self.navigationController?.pushViewController(eatVC, animated: true)
    }
}

extension FruitDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FruitDetailTableViewCell") as! FruitDetailTableViewCell

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
}


