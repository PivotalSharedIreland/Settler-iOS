import UIKit

class PropertyViewController: UIViewController {
    var property: Property?
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        if let property = property {
            addressLabel.text = property.address
        }
    }

}
