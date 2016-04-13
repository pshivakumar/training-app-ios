//
//  AddPartnerViewController.swift
//  TrainingApp
//
//  Created by Vladislav Krasovsky on 4/13/16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey

class AddPartnerViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var saveButtonItem: UIBarButtonItem!
    
    var partner: Partner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
    }
    
    
    func updateSaveButtonState() {
        saveButtonItem.enabled = nameTextField.text?.characters.count > 0 && companyTextField.text?.characters.count > 0
    }
    
    @IBAction func editingChangedForTextField(sender: AnyObject) {
        updateSaveButtonState()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "savePartnerSegueId" {
            partner = Partner(name: nameTextField.text!, company: companyTextField.text!)
        }
    }

}
