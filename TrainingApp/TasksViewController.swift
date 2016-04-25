//
//  ProductsViewController.swift
//  TrainingApp
//
//  Created by Igor Sapyanik on 24.02.16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey
import SVProgressHUD
class TasksViewController: UITableViewController {

    
    var tasks = [Task]()
    
    //TODO: LAB: create sync data store
    lazy var store: DataStore<Task>! = {
        return DataStore<Task>.getInstance(.Sync)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.refreshControl?.addTarget(self, action: #selector(loadDataFromServer), forControlEvents: .ValueChanged)
        
        loadDataFromServer()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if Kinvey.sharedClient.activeUser != nil && self.refreshControl?.refreshing == false {
            loadDataFromCache()
        }
    }

    func loadDataFromServer() {
        
        self.refreshControl?.beginRefreshing()
        //TODO: LAB: pull Todos
        store.pull() { (tasks, error) -> Void in
            self.refreshControl?.endRefreshing()
            if let tasks = tasks {
                self.tasks = tasks
                if self.refreshControl?.refreshing ?? false {
                    self.refreshControl?.endRefreshing()
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func loadDataFromCache(query:Query = Query()) {
        //TODO: LAB: get all Todos by query
        store.find(query) { (tasks, error) -> Void in
            if let tasks = tasks {
                self.tasks = tasks
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func tappedPush(sender: AnyObject) {
        
        SVProgressHUD.show()
        //TODO: LAB: push Todos
        store.sync() { (count, tasks, error) -> Void in
            SVProgressHUD.dismiss()
            if (error != nil) {
                let alert = UIAlertController(title: "Error", message: "Unable to push", preferredStyle:.Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(defaultAction)
                self.tabBarController?.presentViewController(alert, animated:true, completion:nil)
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
        return tasks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")! as! TaskCell

        // Configure the cell...
        if indexPath.row < tasks.count {
            let task = tasks[indexPath.row]
            
            cell.actionLabel?.text = task.action
            cell.dueDateLabel?.text = task.dueDate
            cell.completeLabel?.text = "\(task.completed)"
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
            
            if indexPath.row < tasks.count {
                
                let product = tasks[indexPath.row]
                tasks.removeAtIndex(indexPath.row)
                
                if let _ = product.objectId {
                    
                    SVProgressHUD.show()
                    //TODO: LAB: delete Todos
                    store.removeById(product.objectId!, completionHandler: { (count, error) -> Void in
                        
                        SVProgressHUD.dismiss()
                        
                        if (error != nil) {
                            let alert = UIAlertController(title: "Error", message: "Unable to delete", preferredStyle:.Alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            alert.addAction(defaultAction)
                            self.tabBarController?.presentViewController(alert, animated:true, completion:nil)
                        }
                    })
                }
            }
            
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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

    // MARK: - Navigation

    @IBAction func returnToTaskViewController(segue: UIStoryboardSegue) {
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.

        if let taskDetailsViewController = segue.destinationViewController as? TaskDetailsViewController {
            guard let cell = sender as? TaskCell else {
                return
            }
            
            
            guard let indexPath = self.tableView.indexPathForCell(cell) where indexPath.row < tasks.count else {
                return
            }
            
            let task = tasks[indexPath.row]
            taskDetailsViewController.task = task
        }
    }

}
