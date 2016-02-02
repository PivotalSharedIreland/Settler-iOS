import UIKit


class PropertyListTableViewController: UITableViewController, PropertyServiceDelegate {

    private let propertyCellKey = "PropertyCell"
    private var propertyService: PropertyService!
    private var propertyList: [Property] = []
    private let notificationCenter = NSNotificationCenter.defaultCenter()
    
    @IBAction func didPullToRefresh(sender: UIRefreshControl) {
        refreshProperties()
        self.refreshControl!.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        propertyService = PropertyServiceFactory.propertyService(self)
        
        registerObserver()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshProperties()
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

    func registerObserver() -> Void {
        notificationCenter.addObserver(self, selector: Selector("refreshProperties"), name: UIApplicationWillEnterForegroundNotification, object: nil)
    }

    func loadPropertiesFailure(error: NSError) {
        propertyList = []
        tableView.reloadData()
        UIAlertView(title: "Error", message: "Unable to load properties from the remote service", delegate: nil, cancelButtonTitle: "Okay :-(").show()
    }
    
    internal func refreshProperties() {
        propertyService.performSelector(Selector("loadProperties"), withObject: nil, afterDelay: 0)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell, let indexPath = self.tableView.indexPathForCell(cell),
            let destinationViewController = segue.destinationViewController as? PropertyViewController {
            destinationViewController.property = propertyList[indexPath.row]
        }
    }


    deinit {
        notificationCenter.removeObserver(self)
    }
}
