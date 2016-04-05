//
//  ViewController.swift
//  PlistToCloudkit
//
//  Created by Dawand Sulaiman on 31/03/2016.
//  Copyright © 2016 carrotApps. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController,CloudKitDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlistCloud.delegate = self
        
        PlistCloud.setContainer("iCloud.com.carrotApps.plist")
        PlistCloud.setRecord("contact")
        PlistCloud.setFields(["id","name"])
        PlistCloud.setFileName("contact")
    }

    @IBOutlet weak var startButton: UIButton!
    @IBAction func uploadToCloudkit(sender: AnyObject) {
        PlistCloud.plistToCloudkit()
        startButton.enabled=false
    }
    
    func errorUpdating(error: NSError){
        UIAlertView.init(title: "error", message: error.localizedDescription, delegate: self, cancelButtonTitle: "Dismiss").show()
        startButton.enabled = true
    }
    func modelUpdated(){
        UIAlertView.init(title: "success", message:"successfully uploaded to Cloudkit", delegate: self, cancelButtonTitle: "Dismiss").show()
        startButton.enabled = true
    }
}