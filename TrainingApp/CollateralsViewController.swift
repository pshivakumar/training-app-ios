//
//  CollateralsViewController.swift
//  TrainingApp
//
//  Created by Igor Sapyanik on 3/29/16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey
import SVProgressHUD

class CollateralsViewController: UITableViewController {

    
    var files = [File]()
    
    lazy var fileStore: FileStore! = {
        return FileStore.getInstance()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = true
        self.refreshControl?.addTarget(self, action: #selector(loadDataFromServer), forControlEvents: .ValueChanged)
        loadDataFromServer()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadDataFromServer() {
        self.refreshControl?.beginRefreshing()
        //TODO: LAB: Get files from Kinvey
        //crash when quering pdf files (mimeType is nil )
        //let query = Query(format: "mimeType == %@", "application/pdf")
        let query = Query()
        fileStore.find(query, ttl: nil, completionHandler: { (files, error) -> Void in
            self.refreshControl?.endRefreshing()
            if let files = files {
                self.files = files
                if self.refreshControl?.refreshing ?? false {
                    self.refreshControl?.endRefreshing()
                }
                self.tableView.reloadData()
            }
        })
      }
    

// MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")!
        
        // Configure the cell...
        if indexPath.row < files.count {
            let file = files[indexPath.row]
            
            cell.textLabel?.text = file.fileName
        }
        return cell
    }



// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    
        if let filePreviewViewController = segue.destinationViewController as? FilePreviewViewController {
            
            guard let indexPath = self.tableView.indexPathForSelectedRow where indexPath.row < files.count else {
                return
            }

            let file = files[indexPath.row]
            filePreviewViewController.file = file
        }
}
    
    
}
