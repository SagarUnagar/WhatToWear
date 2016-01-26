//
//  HomeViewController.swift
//  WhatToWear
//
//  Created by Sagar Unagar on 24/01/16.
//  Copyright © 2016 Sagar Unagar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Declaration
    
    //Interface builder declaration
    @IBOutlet var tabNavigation: UITabBar!
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var btnCamera: UIButton!
    @IBOutlet var tblImages:UITableView!
    var imagePicker: UIImagePickerController!
    
    //User define variable declaration
    
    let appData = NSUserDefaults.standardUserDefaults()
    let dbPath = NSBundle.mainBundle().pathForResource("WhatToWear", ofType:"sqlite")
    var dictOneTableRowData = Dictionary<String, Any>()
    var arrayTableData = Array<Dictionary<String, Any>>()
    
    // MARK: - Predefine Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.appData.objectForKey("FBUserName"))
        print(self.appData.objectForKey("FBUserProfileImage"))
        
        tabNavigation.selectedItem=tabNavigation.items![0] as UITabBarItem
        
        //Reaveal view controller configuration
        if self.revealViewController() != nil {
           btnMenu.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().tapGestureRecognizer()
        }
        
        //Database Configuration to get all the images from local db
        
//        let path = NSBundle.mainBundle().pathForResource("WhatToWear", ofType:"sqlite")
        let database = FMDatabase(path: dbPath)
        
        if database.open()
        {
            if let rs = database.executeQuery("select * from MasterTable", withArgumentsInArray: nil)
            {
                while rs.next() {
                    dictOneTableRowData = ["ID":rs.intForColumn("ID"),"ProfileImage":rs.dataForColumn("Image"),"isBookmark":rs.boolForColumn("isBookmark")]
                    arrayTableData.append(dictOneTableRowData)
                    print(dictOneTableRowData)
                    print(arrayTableData)
                }
            }
            else
            {
                print("executeQuery failed: \(database.lastErrorMessage())")
            }
            
            database.close()
        }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Buttons Pressed Events
    @IBAction func btnCamera_Pressed(sender: UIButton) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Choose", message: "What to wear!", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .Default) { action -> Void in
            self.imagePicker =  UIImagePickerController()
            self.imagePicker.delegate=self
            self.imagePicker.sourceType = .Camera
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }
        actionSheetController.addAction(takePictureAction)
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .Default) { action -> Void in
            self.imagePicker =  UIImagePickerController()
            self.imagePicker.delegate=self
            self.imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }
        actionSheetController.addAction(choosePictureAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    // MARK:- Tableview Datasource Mehtods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTableData.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ImageCell Configuration
        
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
