//
//  ItemDetail.swift
//  aggle
//
//  Created by Jose Lemus on 4/21/16.
//  Copyright © 2016 Max Li. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ItemDetail: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var itemDescription: UITextField!
    
    @IBOutlet weak var itemPrice: UITextField!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var itemImageView : UIImageView!
    
    
     let rootRef = Firebase(url:"https://aggle.firebaseio.com/")
     var tempUI = UIImage()
     var base64String = String()
     var zipCode = User.sharedInstance.zip
    
    
    
    
    override func viewDidLoad() {
        itemImageView.image = tempUI // this displays the image
        if (itemImageView.image != nil){
            base64Encode()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        print("hi hi")
    }
    
    
    func base64Encode(){
        let image : UIImage = itemImageView.image! as UIImage
        let imageData = UIImagePNGRepresentation(image)
        
        self.base64String = String(imageData!.base64EncodedDataWithOptions(.Encoding64CharacterLineLength))
    }
    
    
    
    @IBAction func setItemDetails(sender: AnyObject) {
        
        descriptionLabel.text = itemDescription.text
        print("Final Price is ")
        priceLabel.text = itemPrice.text
        updateDataBase(descriptionLabel.text!, price: priceLabel.text!)
        
        
    }
    
    
    func updateDataBase(description:String, price: String){
        let itemDescription = description
        let itemPrice = price
        let itemZipCode = self.zipCode
        let ownerID = rootRef.authData.uid
        let base64String = self.base64String
        let soldTo = "someone"
        
        
        let zipRef = rootRef.childByAppendingPath("ZipDB/" + "10029").childByAutoId()
        let zipInfo = ["Description": itemDescription, "Price" : itemPrice, "ItemZipCode" : "10029", "OwnerID" : ownerID, "base64Encoding" : base64String, "BuyerID" : soldTo]
        
        zipRef.setValue(zipInfo)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
