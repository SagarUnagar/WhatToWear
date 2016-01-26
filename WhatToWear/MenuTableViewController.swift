//
//  MenuTableViewController.swift
//  WhatToWear
//
//  Created by Sagar Unagar on 25/01/16.
//  Copyright © 2016 Sagar Unagar. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    // MARK: - Declartion
    let appData = NSUserDefaults.standardUserDefaults()
    
    // MARK: - Predefine Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        print(appData.stringForKey("FBUserName"))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LabelCell", forIndexPath: indexPath)
        cell.textLabel?.font = UIFont(name: "Avenir-Book", size: 15.0)
        cell.textLabel?.text = "Logout"
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 50.0;
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if(indexPath.row == 0)
        {
            self.appData.setObject(nil, forKey: "FBUserName")
            self.appData.setObject(nil, forKey: "FBUserProfileImage")
            
            self.revealViewController().navigationController?.popToRootViewControllerAnimated(true)
        }
    }

}
