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
        ops.savePolicy = CKModifyRecordsOperation.RecordSavePolicy.ifServerRecordUnchanged
        publicDatabase.add(ops)
        
        records = [CKRecord]()
        
        let plistUrl = Bundle.main.path(forResource: PlistFileName, ofType: "plist")
        let plistData = try! Data(contentsOf: URL(fileURLWithPath: plistUrl!))
        let plistArray = try! PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as! [[String:String]]
        
        for x in 0 ..< plistArray.count {
            
            RecordType = CKRecord(recordType: PlistFileName)
            
            for i in 0 ..< fieldsArray.count  {
                let fieldRow = plistArray[x][fieldsArray[i]]
                RecordType.setValue(fieldRow, forKey: fieldsArray[i])
            }
            
            print(RecordType!)
            
            records.append(RecordType)
        }
        
        let uploadOperation = CKModifyRecordsOperation.init(recordsToSave: records, recordIDsToDelete: nil)
        uploadOperation.savePolicy = .ifServerRecordUnchanged // default
        uploadOperation.modifyRecordsCompletionBlock = { savedRecords, deletedRecordsIDs, error in
            
            if error != nil {
                print("Error saving records: \(error!.localizedDescription)")
                self.delegate?.errorUpdating(error: error! as NSError)
            } else {
                print("Successfully saved records")
                self.delegate?.modelUpdated()
                return
            }
        }
        publicDatabase.add(uploadOperation)
    }
}
