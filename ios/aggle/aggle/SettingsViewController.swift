//
//  SettingsViewController.swift
//  aggle
//
//  Created by Max Li on 4/17/16.
//  Copyright © 2016 Max Li. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var zipCode: UITextField!
    let user = User.sharedInstance
    var TAG: String = "SettingsViewController"
    
    func load_image(urlString:String) {
        print(TAG + "load_image")
        let imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            if (error == nil && data != nil) {
                func display_image() {
                    self.pic.image = UIImage(data: data!)
                }
                dispatch_async(dispatch_get_main_queue(), display_image)
            }
        }
        
        task.resume()
    }
    
    override func viewDidLoad() {
        print(TAG + "viewDidLoad")
        super.viewDidLoad()
        self.navigationItem.title = "Aggle"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.pic.layer.borderWidth = 4
        self.pic.layer.borderColor = UIColor.redColor().CGColor
        self.pic.layer.cornerRadius = pic.frame.size.height/2
        self.pic.layer.masksToBounds = true;
        
        
        load_image(self.user.pic)
        name.text = self.user.name
        zipCode.text = self.user.zip
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(SettingsViewController.setBttnTouched(_:)))
        
        
    }
    
    
    func setBttnTouched(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier("ViewControllerSegue", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    //}
}
