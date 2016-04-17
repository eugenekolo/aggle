//
//  ViewController.swift
//  aggle
//
//  Created by Max Li on 3/3/16.
//  Copyright © 2016 Max Li. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var zipText: UITextField!
    let ref = Firebase(url:"https://aggle.firebaseio.com/")
    var mainZipCode : String = ""
    
    @IBAction func enterZip(sender: AnyObject) {
        self.mainZipCode = zipText.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("[\nViewController/viewDidLoad] hi");
        FBSDKAccessToken.setCurrentAccessToken(nil)  // for debugging when a new user logs in
        FBSDKProfile.setCurrentProfile(nil)
        
        
        
        if (FBSDKAccessToken.currentAccessToken() != nil){  // if user has token, go to main screen
            print("AccessToken exists");
            print(FBSDKAccessToken.currentAccessToken().userID)
            
            self.performSegueWithIdentifier("showNew", sender: self)
            
        }
        
        else{   //if user doesn't have token, go here
            
            
            FBSDKAccessToken.setCurrentAccessToken(nil)  // for debugging when a new user logs in
            FBSDKProfile.setCurrentProfile(nil)
            

            print("AccessToken doesn't exist exists")
            
            
            //print(FBSDKAccessToken.currentAccessToken().userID)
            
            let loginButton = FBSDKLoginButton()
            loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            loginButton.center = self.view.center
            loginButton.delegate = self
            
            self.view.addSubview(loginButton)
            print("here, loaded correctly")
            
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: -- Facebook Login
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        print("[\nViewController/loginButton] hi");
        
        
        if error != nil {  // This means we have an error
            print(error.localizedDescription)
            
        }
        
        
        
        else {
            
            print("[\nViewController/loginButton] in login else");
            
            
            
            
            let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
            
            ref.authWithOAuthProvider("facebook", token: accessToken,
                withCompletionBlock: { error, authData in
                    
                    
                    self.performSegueWithIdentifier("showNew", sender: self) //here new change
                    
                    print(authData)
                    print("Logged in! \(authData) The Users uid is \(authData.uid)")
                    print("And their display name is \(authData.providerData["displayName"])")
                    print("And their email is \(authData.providerData["email"])")
                    //_ = String(authData.uid)
                        
                    let userDisplayName = String(authData.providerData["displayName"])   // probably btter way of doing this
                        
                    let userEmail = String(authData.providerData["email"])
                    let zipCode = self.mainZipCode
                    
                    
                    let userInfo = ["Full Name" : userDisplayName, "Email": userEmail, "Zip Code": zipCode] // key is uid
                        
                    let usersRef = self.ref.childByAppendingPath("users")
                    print("zipcode is " + self.mainZipCode)
                        
                    let users = [authData.uid : userInfo]
//                    
//                    self.ref.observeSingleEventOfType(.Value, withBlock: {
//                        snapshot in 
//                    })
                    
                    usersRef.updateChildValues(users)
            })
            
        }
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("in logout");
        
    }

    
    
}

