//
//  DataModel.swift
//  CheckItNow
//
//  Created by mac os on 10.06.16.
//  Copyright © 2016 Khrystenko Dmytro. All rights reserved.
//

import Foundation

class DataModel {
    
    var lists = [CheckItNow]()
    
    var indexOfSelectedCheckItNow: Int {
        
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey("CheckItNowIndex")
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "CheckItNowIndex")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    
    
    init() {
        
        loadCheckItNow()
        registerDefaults()
        handleFirstTime()
    }
    
    
    func documentsDirectory() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        return paths[0]
    }
    
    
    func dataFilePath() -> String {
        
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("CheckItNow.plist")
    }
    
    
    func saveCheckItNow() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(lists, forKey: "CheckItNow")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    
    
    func loadCheckItNow() {
        
        let path = dataFilePath()
        
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                lists = unarchiver.decodeObjectForKey("CheckItNow") as! [CheckItNow]
                unarchiver.finishDecoding()
                sortCheckItNow()
            }
        }
    }
    
    
    
    func registerDefaults() {
        
        let dictionary = [ "CheckItNowIndex": -1, "FirstTime": true ]
        
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
    
    
    func handleFirstTime() {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let firstTime = userDefaults.boolForKey("FirstTime")
        
        if firstTime {
            let checkItNow = CheckItNow(name: "List")
            lists.append(checkItNow)
            indexOfSelectedCheckItNow = 0
            userDefaults.setBool(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
    }
    
    
    func sortCheckItNow() {
        lists.sortInPlace({ checkitnow1, checkitnow2 in return
            checkitnow1.name.localizedStandardCompare(checkitnow2.name) == .OrderedAscending })
        
        }
   

}
