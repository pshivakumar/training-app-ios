//
//  PartnersViewController.swift
//  TrainingApp
//
//  Created by Igor Sapyanik on 24.02.16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey

class PartnersViewController: UITableViewController {

    
    var partners = [Partner]()
    
    lazy var store: DataStore<Partner>! = {
        //Create a DataStore of type "Sync"
        return DataStore<Partner>.getInstance(.Sync)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        self.refreshControl?.addTarget(self, action: "loadDataFromServer", forControlEvents: .ValueChanged)

        loadDataFromServer()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if Kinvey.sharedClient.activeUser != nil && self.refreshControl?.refreshing == false {
            loadDataFromCache()
        }
    }
    
    func loadDataFromServer() {
        
        do {
            self.refreshControl?.beginRefreshing()
            try store.pull() { (partners, error) -> Void in
                self.refreshControl?.endRefreshing()
                if let partners = partners {
                    self.partners = partners
                    if self.refreshControl?.refreshing ?? false {
                        self.refreshControl?.endRefreshing()
                    }
                    self.tableView.reloadData()
                }
            }
        }
        catch {
            
        }
    }
    
    func loadDataFromCache() {
        
        store.find { (partners, error) -> Void in
            if let partners = partners {
                self.partners = partners
                self.tableView.reloadData()
            }
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        self.refreshControl?.enabled = !editing;
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partners.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")!

        // Configure the cell...
        if indexPath.row < partners.count {
            let product = partners[indexPath.row]
            
            cell.textLabel?.text = product.name
            cell.detailTextLabel?.text = product.company
        }

        return cell
    }

}
