import UIKit

class PropertyEditViewController: UIViewController {
    var property: Property?
    
    @IBOutlet weak var addressTextField: UITextField!
    override func viewWillAppear(animated: Bool) {
        if let property = property {
            addressTextField.text = property.address
        }

    }

}