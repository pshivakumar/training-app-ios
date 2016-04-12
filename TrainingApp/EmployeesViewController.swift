//
//  EmployeesViewController.swift
//  TrainingApp
//
//  Created by Vladislav Krasovsky on 4/12/16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey
import SVProgressHUD

class EmployeesViewController: UITableViewController {

    var employees = [Employee]()
    
    lazy var store: DataStore<Employee>! = {
        return DataStore<Employee>.getInstance(.Cache)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        self.refreshControl?.addTarget(self, action: #selector(loadDataFromCache), forControlEvents: .ValueChanged)
        
        loadDataFromCache()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if Kinvey.sharedClient.activeUser != nil && self.refreshControl?.refreshing == false {
            loadDataFromCache()
        }
    }
    
//    func loadDataFromServer() {
//        
//        store.pull() { (partners, error) -> Void in
//            self.refreshControl?.endRefreshing()
//            if let employees = employees {
//                self.employees = employees
//                if self.refreshControl?.refreshing ?? false {
//                    self.refreshControl?.endRefreshing()
//                }
//                self.tableView.reloadData()
//            }
//        }
//        
//    }
    
    func loadDataFromCache() {
        self.refreshControl?.beginRefreshing()

        store.find { (employees, error) -> Void in
            self.refreshControl?.endRefreshing()
            if let employees = employees {
                self.employees = employees
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
        return employees.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")!
        
        // Configure the cell...
        if indexPath.row < employees.count {
            let employee = employees[indexPath.row]
            cell.textLabel?.text = employee.name
        }
        
        return cell
    }
    
    @IBAction func tappedPush(sender: AnyObject) {
        
        SVProgressHUD.show()
        store.push() { (count, error) -> Void in
            SVProgressHUD.dismiss()
            if (error != nil) {
                let alert = UIAlertController(title: "Error", message: "Unable to push", preferredStyle:.Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(defaultAction)
                self.tabBarController?.presentViewController(alert, animated:true, completion:nil)
            }
        }
    }

}
