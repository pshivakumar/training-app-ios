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
        User.login(username: login, password: password) { user, error in
            SVProgressHUD.dismiss()
            if let _ = user {
                
                NSNotificationCenter.defaultCenter().postNotificationName(LoginViewController.didLoginNotificationName, object: self)
                
                //do nothing
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                
                //do something!
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
