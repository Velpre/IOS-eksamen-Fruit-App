import Foundation
import UIKit

 
extension UIViewController {
    
    //Alert Message showing errors to user
    func showAlertWith(message: String , style: UIAlertController.Style = .alert, title:String = "Error") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}

//Returing random color
extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }

}



