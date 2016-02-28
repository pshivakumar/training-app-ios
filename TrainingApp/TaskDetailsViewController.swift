//
//  TaskDetailsViewController.swift
//  TrainingApp
//
//  Created by Igor Sapyanik on 28.02.16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey

class TaskDetailsViewController: UIViewController {

    var task: Task!
    
    lazy var store: DataStore<Task>! = {
        //Create a DataStore of type "Sync"
        return DataStore<Task>.getInstance(.Sync)
    }()
    
    @IBOutlet weak var taskActionField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        taskActionField.text = task.action
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        taskActionField.becomeFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func tappedSave(sender: AnyObject) {
        
        task.action = taskActionField.text
        store.save(task) { (savedTask, error) -> Void in
            
            if error == nil {
                self.navigationController?.popViewControllerAnimated(true)
            }
            else {
                let alert = UIAlertController(title: "Error", message: "Unable to save", preferredStyle:.Alert)
                self.tabBarController?.presentViewController(alert, animated:true, completion:nil)
            }
        }
    }

}
