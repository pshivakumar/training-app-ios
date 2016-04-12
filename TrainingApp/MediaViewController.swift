//
//  MediaViewController.swift
//  TrainingApp
//
//  Created by Vladislav Krasovsky on 4/12/16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey

class MediaViewController: UITableViewController {

    var medias = [Media]()
    
    lazy var store: DataStore<Media>! = {
        return DataStore<Media>.getInstance(.Network)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        self.refreshControl?.addTarget(self, action: #selector(loadDataFromServer), forControlEvents: .ValueChanged)
        
        loadDataFromServer()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if Kinvey.sharedClient.activeUser != nil && self.refreshControl?.refreshing == false {
            loadDataFromServer()
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
    
    func loadDataFromServer() {
        self.refreshControl?.beginRefreshing()
        
        store.find { (medias, error) -> Void in
            self.refreshControl?.endRefreshing()
            if let medias = medias {
                self.medias = medias
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
        return medias.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")!
        
        // Configure the cell...
        if indexPath.row < medias.count {
            let media = medias[indexPath.row]
            cell.textLabel?.text = media.name
        }
        
        return cell
    }

}
