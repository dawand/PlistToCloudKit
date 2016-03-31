//
//  File.swift
//  PlistToCloudkit
//
//  Created by Dawand Sulaiman on 31/03/2016.
//  Copyright © 2016 carrotApps. All rights reserved.
//

import Foundation
import CloudKit

//protocol PlistProtocol {
//    func finishedUploading(){
//    }
//}

class PlistCloud: NSObject {
    
    static var publicDatabase:CKDatabase!
    static var RecordType: CKRecord!
    static var fieldsArray: [String]!
    static var records: [CKRecord]!
    
 //   override init() {
 //       records = [CKRecord]()
 //   }
    
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
    
    static func plistToCloudkit(PlistFile: String) {
        
        let ops:CKModifyRecordsOperation = CKModifyRecordsOperation()
        ops.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        publicDatabase.addOperation(ops)
        
        records = [CKRecord]()
        
            if let arrayQuotes = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource(PlistFile, ofType: "plist")!) {
                
                for x in 0 ..< arrayQuotes.count {
                    
                    RecordType = CKRecord(recordType: "contact", recordID: CKRecordID(recordName: "contact\(x)"))
                    let fieldRow = arrayQuotes[x].objectForKey("name")!
                    let fieldRow2 = arrayQuotes[x].objectForKey("id")!

                    RecordType.setValue(fieldRow, forKey: "name")
                    RecordType.setValue(fieldRow2, forKey: "id")

                    for i in 0 ..< fieldsArray.count  {
                        RecordType = CKRecord(recordType: PlistFile, recordID: CKRecordID(recordName: PlistFile+"\(x)"))
                       let fieldRow = arrayQuotes[x].objectForKey(fieldsArray[i])!
                        RecordType.setValue(fieldRow, forKey: fieldsArray[i])
                    }
                    
                    print(RecordType)
                    
                    records.append(RecordType)
                }
            }
        
        let uploadOperation = CKModifyRecordsOperation.init(recordsToSave: records, recordIDsToDelete: nil)
        uploadOperation.savePolicy = .IfServerRecordUnchanged // default
        uploadOperation.modifyRecordsCompletionBlock = { savedRecords, deletedRecordsIDs, error in
            if error != nil {
                print("Error saving records: \(error!.localizedDescription)")
            } else {
                print("Successfully saved records")
            }
        }
        publicDatabase.addOperation(uploadOperation)
        
    }
}