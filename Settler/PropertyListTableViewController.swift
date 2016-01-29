import UIKit


class PropertyListTableViewController: UITableViewController, PropertyServiceDelegate {

    private let propertyCellKey = "PropertyCell"
    private var propertyService: PropertyService!
    private var propertyList: [Property] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        propertyService = PropertyServiceFactory.propertyService(self)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        propertyService.performSelector(Selector("loadProperties"), withObject: nil, afterDelay: 0)
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertyList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(propertyCellKey) as! PropertyCell
        let property = propertyList[indexPath.row]
        cell.addressLabel.text = property.address
        return cell
    }

    internal func loadPropertiesSuccess(properties: [Property]) {
        propertyList = properties
        tableView.reloadData()
    }

    func loadPropertiesFailure(error: NSError) {
    }


}
