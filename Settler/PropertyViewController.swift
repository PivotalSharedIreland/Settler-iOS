import UIKit

class PropertyViewController: UIViewController {
    var property: Property?
    @IBOutlet weak var addressLabel: UILabel!
    @IBAction func backToPropertyViewController(unwindSegue: UIStoryboardSegue) {}
    
    override func viewWillAppear(animated: Bool) {
        if let property = property {
            addressLabel.text = property.address
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let property = property, let editViewController = segue.destinationViewController as? PropertyEditViewController {
            editViewController.property = property
        }
    }

}
