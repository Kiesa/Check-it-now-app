//
//  ListDetailViewController.swift
//  CheckItNow
//
//  Created by mac os on 08.06.16.
//  Copyright © 2016 Khrystenko Dmytro. All rights reserved.
//


import UIKit

protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingToCheckItNow checkItNow: CheckItNow)
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingInCheckItNow checkItNow: CheckItNow)
}


class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var iconImageView: UIImageView!
    
    weak var delegate: ListDetailViewControllerDelegate?
    
    var checkItNowToEdit: CheckItNow?
    var iconName = "No Icon"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let checkItNow = checkItNowToEdit {
            title = "Edit List"
            textField.text = checkItNow.name
            doneBarButton.enabled = true
            iconName = checkItNow.iconName
        }
        
        iconImageView.image = UIImage(named: iconName)
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    
    
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        if indexPath.section == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "PickIcon" {
            let controller = segue.destinationViewController as! IconPickerViewController
            controller.delegate = self
        }
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        doneBarButton.enabled = (newText.length > 0)
        
        return true
    }
    
    
    
    
    @IBAction func cancel() {
        
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    
    
    
    @IBAction func done() {
        
        if let checkItNow = checkItNowToEdit {
            checkItNow.name = textField.text!
            checkItNow.iconName = iconName
            delegate?.listDetailViewController(self, didFinishEditingInCheckItNow: checkItNow)
        } else {
            let checkItNow = CheckItNow(name: textField.text!, iconName: iconName)
            delegate?.listDetailViewController(self, didFinishAddingToCheckItNow: checkItNow)
        }
    }
    
    func iconPicker(picker: IconPickerViewController, didPicIcon iconName: String) {
        
        self.iconName = iconName
        iconImageView.image = UIImage(named: iconName)
        navigationController?.popViewControllerAnimated(true)
    }
}
