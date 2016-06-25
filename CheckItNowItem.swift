//
//  CheckItNowItem.swift
//  CheckItNow
//
//  Created by mac os on 30.05.16.
//  Copyright © 2016 Khrystenko Dmytro. All rights reserved.
//

import Foundation

class CheckItNowItem: NSObject, NSCoding {
    
    var text = ""
    var checked = false
    
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        text = aDecoder.decodeObjectForKey("Text") as! String
        checked = aDecoder.decodeBoolForKey("Checked")
        
        super.init()
    }
    
    
    
    override init() {
        
        super.init()
    }
    
    
    
    func toggleChecked() {
        
        checked = !checked
    }
}