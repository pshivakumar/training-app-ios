//
//  LogoutViewController.swift
//  TrainingApp
//
//  Created by Vladislav Krasovsky on 4/14/16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey
import SVProgressHUD

class LogoutViewController: UIViewController {

    @IBAction func logoutPressed(sender: AnyObject) {
        //TODO: LAB: Get the active user and logout
        Kinvey.sharedClient.activeUser?.logout()
        self.tabBarController!.performSegueWithIdentifier("TabBarToLogin", sender: nil)
        self.tabBarController!.selectedIndex = 0
    }

}
