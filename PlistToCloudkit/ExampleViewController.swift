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
        
        PlistCloud.setContainer(container: CONTAINER_NAME)
        PlistCloud.setRecord(record: RECORD_NAME)
        PlistCloud.setFields(fields: FIELD_NAMES)
        PlistCloud.setFileName(filename: FILE_NAME)
    }

    @IBOutlet weak var startButton: UIButton!
    @IBAction func uploadToCloudkit(sender: AnyObject) {
        PlistCloud.plistToCloudkit()
        startButton.isEnabled=false
    }
    
    func errorUpdating(error: NSError){
        let alert = UIAlertController.init(title: "error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        
        startButton.isEnabled = true
    }
    func modelUpdated(){
        let alert = UIAlertController(title: "success", message: "successfully uploaded to Cloudkit", preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)

        startButton.isEnabled = true
    }
}
