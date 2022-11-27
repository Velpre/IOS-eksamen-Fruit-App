import UIKit

class FruitGroupViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataBrain = FruitDataBrain()
    var apiManager = ApiManager()
    //Storage of data for GroupViewController
    var sectionArray:[SectionData] = []
    //Storage of fruits we send to FruitListViewController
    var fruitList = [Fruit]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        sectionArray = dataBrain.getGroupData()
        collectionView.reloadData()
        
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
    }
    
    func navigateToFruitList(url:String){
        let listVC = self.storyboard?.instantiateViewController(identifier: "FruitListViewController") as! FruitListViewController
        listVC.urlString = url
        self.navigationController?.pushViewController(listVC, animated: true)
    }
}


extension FruitGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 155)
    }
    

    
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

       switch kind {

       case UICollectionView.elementKindSectionHeader:
           let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
           headerView.nameLabel.text = sectionArray[indexPath.section].title
            return headerView

         default:
                assert(false, "Unexpected element kind")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 40) / 3)
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionArray[section].list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FruitCategoryCell", for: indexPath) as! FruitCategoryCell
        let name = sectionArray[indexPath.section].list[indexPath.row]
        cell.nameLabel.text = name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionObject = sectionArray[indexPath.section]
        switch sectionObject.sectionType {
        case .family:
            let name = sectionObject.list[indexPath.row]
            let url = "https://www.fruityvice.com/api/fruit/family/\(name)"
            navigateToFruitList(url: url)
        case .genus:
            let name = sectionObject.list[indexPath.row]
            let url = "https://www.fruityvice.com/api/fruit/genus/\(name)"
            navigateToFruitList(url: url)

        case .order:
            let name = sectionObject.list[indexPath.row]
            let url = "https://www.fruityvice.com/api/fruit/order/\(name)"
            navigateToFruitList(url: url)
        }
    }
}


