//
//  CheckItNow.swift
//  CheckItNow
//
//  Created by mac os on 08.06.16.
//  Copyright © 2016 Khrystenko Dmytro. All rights reserved.
//

import UIKit

class CheckItNow: NSObject, NSCoding {
    var name = ""
    var items = [CheckItNowItem]()
    var iconName: String
    
    convenience init(name: String) {
        
        self.init(name: name, iconName: "No Icon")
    }
    
    init(name: String, iconName: String) {
        
        self.name = name
        self.iconName = iconName
        super.init()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        name = aDecoder.decodeObjectForKey("Name") as! String
        items = aDecoder.decodeObjectForKey("Items") as! [CheckItNowItem]
        iconName = aDecoder.decodeObjectForKey("IconName") as! String
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
        aCoder.encodeObject(iconName, forKey: "IconName")
    }
    
    func countUncheckedItem() -> Int {
        
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
}
