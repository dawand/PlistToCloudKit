//
//  File.swift
//  PlistToCloudkit
//
//  Created by Dawand Sulaiman on 31/03/2016.
//  Copyright © 2016 carrotApps. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

protocol CloudKitDelegate {
    func errorUpdating(error: NSError)
    func modelUpdated()
}

class PlistCloud: NSObject {
    
    static var publicDatabase:CKDatabase!
    static var RecordType: CKRecord!
    static var fieldsArray: [String]!
    static var records: [CKRecord]!
    static var result: String!
    static var PlistFileName: String!
    
    static var delegate : CloudKitDelegate?

    static func setContainer(container: String){
        let container = CKContainer(identifier: container)
        publicDatabase = container.publicCloudDatabase
    }
    
    static func setRecord(record: String){
        RecordType = CKRecord(recordType:record )
    }
    
    static func setFields(fields: [String]){
        fieldsArray = fields
    }
    
    static func setFileName(filename: String){
        PlistFileName = filename
    }
    
    static func plistToCloudkit() {
        
        let ops:CKModifyRecordsOperation = CKModifyRecordsOperation()
        ops.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        publicDatabase.addOperation(ops)
        
        records = [CKRecord]()
        
            if let arrayQuotes = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource(PlistFileName, ofType: "plist")!) {
                
                for x in 0 ..< arrayQuotes.count {

                    RecordType = CKRecord(recordType: PlistFileName)

                    for i in 0 ..< fieldsArray.count  {
                       let fieldRow = arrayQuotes[x].objectForKey(fieldsArray[i])!
                        RecordType.setValue(fieldRow, forKey: fieldsArray[i])
                    }
                    
                    print(RecordType)
                    
                    records.append(RecordType)
                }
            
                    let uploadOperation = CKModifyRecordsOperation.init(recordsToSave: records, recordIDsToDelete: nil)
                    uploadOperation.savePolicy = .IfServerRecordUnchanged // default
                    uploadOperation.modifyRecordsCompletionBlock = { savedRecords, deletedRecordsIDs, error in
                    
                        if error != nil {
                            print("Error saving records: \(error!.localizedDescription)")
                            dispatch_async(dispatch_get_main_queue()) {
                                self.delegate?.errorUpdating(error!)
                            }
                        } else {
                            print("Successfully saved records")
                            dispatch_async(dispatch_get_main_queue()) {
                                self.delegate?.modelUpdated()
                                return
                            }
                        }
                    }
                publicDatabase.addOperation(uploadOperation)
            }
            else{
                print("could not load the plist file!")
            }
        
    }
}