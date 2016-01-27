//
//  PropertyListTableViewController.swift
//  Settler
//
//  Created by Pivotal on 26/01/2016.
//  Copyright (c) 2016 Pivotal Labs. All rights reserved.
//


import UIKit


class PropertyListTableViewController: UITableViewController {

    let propertyCellKey = "PropertyCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(propertyCellKey)!
    }


}
