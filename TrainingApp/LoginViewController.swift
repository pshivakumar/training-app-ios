//
//  LoginViewController.swift
//  TrainingApp
//
//  Created by Igor Sapyanik on 24.02.16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey
import SVProgressHUD

class LoginViewController: UIViewController {

    static let didLoginNotificationName = "didLoginNotificationName"
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedLogin(sender: AnyObject) {
        
        guard let login = loginField.text, let password = passwordField.text
            where login.characters.count > 0 && password.characters.count > 0 else {
            return
        }
        
        SVProgressHUD.show()
        //TODO: LAB: implement user login
            SVProgressHUD.dismiss()
//            if let _ = user {
//                
//                NSNotificationCenter.defaultCenter().postNotificationName(LoginViewController.didLoginNotificationName, object: self)
//                
//                //TODO: LAB: implement push registration
//                
//                //do nothing
//                self.dismissViewControllerAnimated(true, completion: nil)
//            } else {
//                
//                //do something!
//            }
        
    }

    
    @IBAction func tappedLoginWithMIC(sender: UIButton) {
        //TODO: LAB: implement MIC login
//            if (user != nil) {
//                //logged in successfully
//                NSNotificationCenter.defaultCenter().postNotificationName(LoginViewController.didLoginNotificationName, object: self)
//                self.dismissViewControllerAnimated(true, completion: nil)
//            }
        
    }
   

}
