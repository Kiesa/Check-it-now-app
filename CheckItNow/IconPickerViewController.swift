//
//  IconPickerViewController.swift
//  CheckItNow
//
//  Created by mac os on 13.06.16.
//  Copyright © 2016 Khrystenko Dmytro. All rights reserved.
//

import Foundation
import UIKit


protocol IconPickerViewControllerDelegate: class {
    func iconPicker(picker: IconPickerViewController, didPicIcon iconName: String)
}

class IconPickerViewController: UITableViewController{
    
    weak var delegate: IconPickerViewControllerDelegate?
    
    let icons = [
        "Birthday",
        "Finance",
        "No Icon",
        "Shopping",
        "To Do",
        "Travel",
        "Info"]
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let delegate = delegate {
            let iconName = icons[indexPath.row]
            delegate.iconPicker(self, didPicIcon: iconName)
        }
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return icons.count
    }
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("IconCell", forIndexPath: indexPath)
        
        let iconName = icons[indexPath.row]
        cell.textLabel!.text = iconName
        cell.imageView!.image = UIImage(named: iconName)
        
        return cell
    }
}