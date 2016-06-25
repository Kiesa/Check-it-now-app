//
//  ViewController.swift
//  CheckItNow
//
//  Created by mac os on 26.05.16.
//  Copyright © 2016 Khrystenko Dmytro. All rights reserved.
//

import UIKit


class CheckItNowViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    
    
    var checkItNow: CheckItNow!
    
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = checkItNow.name
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkItNow.items.count
    }
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CheckItNowItem", forIndexPath: indexPath)
        let item = checkItNow.items[indexPath.row]
        
        
        configureTextForCell(cell, withCheckItNowItem: item)
        configureCheckmarkForCell(cell, withCheckItNowItem: item)
        
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            let item = checkItNow.items[indexPath.row]
           
          
            item.toggleChecked()
            configureCheckmarkForCell(cell, withCheckItNowItem: item)
        }
        
         tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
            
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        checkItNow.items.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        
    }
    
    
    func configureTextForCell(cell: UITableViewCell, withCheckItNowItem item: CheckItNowItem) {
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }

    
    func configureCheckmarkForCell(cell: UITableViewCell, withCheckItNowItem item: CheckItNowItem) {
        
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }

    
    
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: CheckItNowItem) {
        
        let newRowIndex = checkItNow.items.count
        checkItNow.items.append(item)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: CheckItNowItem) {
        
        if let index = checkItNow.items.indexOf(item) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configureTextForCell(cell, withCheckItNowItem: item)
            }
        }
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AddItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            
        
        let navigationController = segue.destinationViewController as! UINavigationController
        let controller = navigationController.topViewController as! ItemDetailViewController
        controller.delegate = self
        
        if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
            controller.itemToEdit = checkItNow.items[indexPath.row]
        }
        
    }
  }
   
    
}