//
//  ViewController.swift
//  PlistToCloudkit
//
//  Created by Dawand Sulaiman on 31/03/2016.
//  Copyright © 2016 carrotApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func uploadToCloudkit(sender: AnyObject) {
        
        PlistCloud.setContainer("iCloud.com.carrotApps.plist")
        PlistCloud.setRecord("contact")
        PlistCloud.setFields(["id","name"])
        PlistCloud.plistToCloudkit("contact")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

