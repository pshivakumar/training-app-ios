//
//  FilePreviewViewController.swift
//  TrainingApp
//
//  Created by Igor Sapyanik on 3/29/16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit
import Kinvey
import SVProgressHUD

class FilePreviewViewController: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    var file: File!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = file.fileName
        let request = NSURLRequest(URL: file.downloadURL!)
        webView.loadRequest(request)
    }

}
