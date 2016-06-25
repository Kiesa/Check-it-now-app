//
//  AllListViewController.swift
//  CheckItNow
//
//  Created by mac os on 07.06.16.
//  Copyright © 2016 Khrystenko Dmytro. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    
    var dataModel: DataModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataModel.lists.count
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = cellForTableView(tableView)
        
        let checkItNow = dataModel.lists[indexPath.row]
        cell.textLabel!.text = checkItNow.name
        cell.accessoryType = .DetailDisclosureButton
        
        let count = checkItNow.countUncheckedItem()
        if checkItNow.items.count == 0 {
            cell.detailTextLabel!.text = "(No items)"
        } else if count == 0 {
            cell.detailTextLabel!.text = "All done"
        } else {
            cell.detailTextLabel!.text = "\(count) Remaining"
        }
        
        cell.imageView!.image = UIImage(named: checkItNow.iconName)
        
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        dataModel.indexOfSelectedCheckItNow = indexPath.row
        
        let checkItNow = dataModel.lists[indexPath.row]
        performSegueWithIdentifier("ShowCheckItNow", sender: checkItNow)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowCheckItNow" {
            let controller = segue.destinationViewController as! CheckItNowViewController
            controller.checkItNow = sender as! CheckItNow
            
        } else if segue.identifier == "AddCheckItNow" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ListDetailViewController
            controller.delegate = self
            controller.checkItNowToEdit = nil
        }
    }
    
    
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        dataModel.lists.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    
    
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        let navigationController = storyboard!.instantiateViewControllerWithIdentifier("ListDetailNavigationController") as! UINavigationController
        
        let controller = navigationController.topViewController as! ListDetailViewController
        controller.delegate = self
        
        let checkItNow = dataModel.lists[indexPath.row]
        controller.checkItNowToEdit = checkItNow
        
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        
        let index = dataModel.indexOfSelectedCheckItNow
        
        if index >= 0 && index < dataModel.lists.count {
            let checkItNow = dataModel.lists[index]
            performSegueWithIdentifier("ShowCheckItNow", sender: checkItNow)
        }
    }
    
    
    
    
    func cellForTableView(TableView: UITableView) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
    }
    
    
    
    

    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingToCheckItNow checkItNow: CheckItNow) {
        
        dataModel.lists.append(checkItNow)
        dataModel.sortCheckItNow()
        tableView.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingInCheckItNow checkItNow: CheckItNow) {
        
        dataModel.sortCheckItNow()
        tableView.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        
        if viewController === self {
            dataModel.indexOfSelectedCheckItNow = -1
        }
    }
    
}
