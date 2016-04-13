//
//  MediaViewController.swift
//  TrainingApp
//
//  Created by Vladislav Krasovsky on 4/12/16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey
import SVProgressHUD

class MediaViewController: UITableViewController {

    var medias = [Media]()
    
    lazy var store: DataStore<Media>! = {
        return DataStore<Media>.getInstance(.Network)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.refreshControl?.addTarget(self, action: #selector(loadData), forControlEvents: .ValueChanged)
        
        loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if Kinvey.sharedClient.activeUser != nil && self.refreshControl?.refreshing == false {
            loadData()
        }
    }
    
    //always load from server
    func loadData() {
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
        
        if indexPath.row < medias.count {
            let media = medias[indexPath.row]
            cell.textLabel?.text = media.name
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            if indexPath.row < medias.count {
                
                let media = medias[indexPath.row]
                medias.removeAtIndex(indexPath.row)
                
                if let _ = media.objectId {
                    
                    SVProgressHUD.show()
                    store.removeById(media.objectId!, completionHandler: { (count, error) -> Void in
                        
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
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    
    // MARK: - Navigation
    
    @IBAction func cancelAddingMedia(segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveMedia(segue: UIStoryboardSegue) {
        if let addMediaViewController = segue.sourceViewController as? AddMediaViewController {
            
            if let media = addMediaViewController.media {
                SVProgressHUD.show()

                store.save(media) { (media, error) -> Void in
                    SVProgressHUD.dismiss()

                    if error != nil {
                        let alert = UIAlertController(title: "Error", message: "Unable to save", preferredStyle:.Alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        alert.addAction(defaultAction)
                        self.tabBarController?.presentViewController(alert, animated:true, completion:nil)
                    }
                    
                    if let media = media{
                        self.medias.append(media);
                        self.tableView.reloadData()
                    }
                }

            }
        }
    }

   
}
