//
//  AddTaskViewController.swift
//  TrainingApp
//
//  Created by Igor Sapyanik on 28.02.16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey

class AddTaskViewController: UIViewController {

    @IBOutlet weak var actionField: UITextField!
    @IBOutlet weak var completedSwitch: UISwitch!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var saveButtonItem: UIBarButtonItem!

    var task: Task?
    lazy var store: DataStore<Task>! = {
        //Create a DataStore of type "Sync"
        return DataStore<Task>.getInstance(.Sync)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func updateSaveButtonState() {
        saveButtonItem.enabled = actionField.text?.characters.count > 0
    }
    
    @IBAction func editingChangedForTextField(sender: AnyObject) {
        updateSaveButtonState()
    }
    
    @IBAction func tappedSave(sender: AnyObject) {
        
        let task = Task()
        task.action = actionField.text
        task.completed = completedSwitch.on
        //TODO: fix due date
        task.dueDate = "2016-02-25T12:33:09.124Z"
        store.save(task) { (task, error) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: "Unable to save", preferredStyle:.Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(defaultAction)
                self.tabBarController?.presentViewController(alert, animated:true, completion:nil)
            }
        }
    }
}
