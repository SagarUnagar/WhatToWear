//
//  ViewController.swift
//  WhatToWear
//
//  Created by Sagar Unagar on 24/01/16.
//  Copyright © 2016 Sagar Unagar. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController {
    
    // MARK: - Declaration
    @IBOutlet var btnFBLogin:UIButton!
    let appData = NSUserDefaults.standardUserDefaults()

    // MARK: - Predefine Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // To check wheather user is logged in using facebook credential of not
        print(appData.stringForKey("FBUserName"))
        print(appData.stringForKey("FBUserProfileImage"))
        if(appData.stringForKey("FBUserName") != nil)
        {
            print("User is already logged in!")
            self.performSegueWithIdentifier("PushHomeView", sender: self)
        }
        else
        {
            print("User is not logged in")
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Buttons Pressed Events
    @IBAction func btnFBLogin_Pressed(sender: UIButton) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        if(appData.stringForKey("FBUserName") == nil)
        {
        fbLoginManager.logInWithReadPermissions(["public_profile","email"], fromViewController: self)
            {
                (result,error) -> Void in
                if(result.isCancelled)
                {
                    print("Cancelled")
                }
                else if(error == nil)
                {
                    let fbLoginResult: FBSDKLoginManagerLoginResult = result
                    if(fbLoginResult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                    }
                }
                else
                {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Mark: - User Define Method
    //This method is used to retrive facebook user information after getting successful grant permission
    func getFBUserData() {
        if((FBSDKAccessToken.currentAccessToken()) != nil)
        {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil)
                {
                    print(result)
                    print(result.valueForKey("name"))
                    print(result.valueForKey("picture")?.valueForKey("data")?.valueForKey("url"))
                    print(result.valueForKey("email"))
                    self.appData.setObject(result.valueForKey("name"), forKey: "FBUserName")
                    self.appData.setObject(result.valueForKey("picture")?.valueForKey("data")?.valueForKey("url"), forKey: "FBUserProfileImage")

                }
            })
        }
    }
}

