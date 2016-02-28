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
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.refreshControl?.addTarget(self, action: "reloadDataFromServer", forControlEvents: .ValueChanged)
        
        if Kinvey.sharedClient.activeUser == nil {
            self.tabBarController!.performSegueWithIdentifier("TabBarToLogin", sender: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if Kinvey.sharedClient.activeUser != nil {
            reloadDataFromCache()
        }
    }
    
    func reloadDataFromServer() {
        
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
    
    func reloadDataFromCache() {
        
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

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
