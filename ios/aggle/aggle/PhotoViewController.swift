//
//  PhotoViewController.swift
//  aggle
//
//  Created by Max Li on 3/22/16.
//  Copyright © 2016 Max Li. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    
    @IBOutlet weak var currentImage: UIImageView!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    internal var base64Image = "";
    
     let ref = Firebase(url:"https://aggle.firebaseio.com/")
    
    
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var capturedImage: UIImageView!

    
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.navigationItem.title = "Aggle"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: #selector(PhotoViewController.setBttnTouched(_:)))
        
        
        
        //===================== NEW FUNCTION =======================//
        //===================== NEW FUNCTION =======================//
        //===================== NEW FUNCTION =======================//
        if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let myAlertView: UIAlertView = UIAlertView(title: "Error", message: "Device has no camera", delegate: nil, cancelButtonTitle: "OK", otherButtonTitles: "")
            myAlertView.show()
        }
    }
    //===================== NEW FUNCTION =======================//
    //===================== NEW FUNCTION =======================//
    //===================== NEW FUNCTION =======================//
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        //captureSession = AVCaptureSession()
        //captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
        
        //let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        //var error: NSError?
//        var input: AVCaptureDeviceInput!
//        do {
//            input = try AVCaptureDeviceInput(device: backCamera)
//        } catch let error1 as NSError {
//            error = error1
//            input = nil
//        }
//        
//        if error == nil && captureSession!.canAddInput(input) {
//            captureSession!.addInput(input)
//            
//            stillImageOutput = AVCaptureStillImageOutput()
//            stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
//            if captureSession!.canAddOutput(stillImageOutput) {
//                captureSession!.addOutput(stillImageOutput)
//                
//                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//                previewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
//                previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
//                previewView.layer.addSublayer(previewLayer!)
//                captureSession!.startRunning()
//            }
//        }
        
    }
    
    
    
    
    
    
    @IBAction func selectPhoto(sender: UIButton) {
        
        //===================== NEW FUNCTION =======================//
        //===================== NEW FUNCTION =======================//
        //===================== NEW FUNCTION =======================//
        
        var picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .PhotoLibrary
        self.presentViewController(picker, animated: true, completion: { _ in })
        
        
        //===================== NEW FUNCTION =======================//
        //===================== NEW FUNCTION =======================//
        //===================== NEW FUNCTION =======================//
        
        
    }
    
    
    
    @IBAction func didPressTakePhoto(sender: UIButton) {
        
        // commenting out commenting out =========================///
//        if let videoConnection = stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo) {
//            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
//            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(sampleBuffer, error) in
//                if (sampleBuffer != nil) {
//                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
//                    let dataProvider = CGDataProviderCreateWithCFData(imageData)
//                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
//                    
//                    
//                    //let image = UIImageView(image: cgImageRef!, highlightedImage: 1.0)
//                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
//                    self.capturedImage.image = image
//                    //self.previewView.i = image
//                    
//                }
//            })
//        }
        
        
        
        //===================== NEW FUNCTION =======================//
        //===================== NEW FUNCTION =======================//
        //===================== NEW FUNCTION =======================//
        
        
        let picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .Camera
        self.presentViewController(picker, animated: true, completion: { _ in })
        
        
        //===================== NEW FUNCTION =======================//
        //===================== NEW FUNCTION =======================//
        //===================== NEW FUNCTION =======================//
        
    }

    
    
    @IBAction func didPressTakeAnother(sender: AnyObject) {
        captureSession!.startRunning()
    }
    
    
    func setBttnTouched(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier("photoSettingsSegue", sender: self)
        
    }
    

    @IBAction func takePicture(sender: UIButton) {
        
        let picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .Camera
        self.presentViewController(picker, animated: true, completion: { _ in })
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //===========================================================================================
    //============= code below is for base64 encoding of picture when pushed to db //============================
    //============================================================================================
    
    
    
    
    @IBOutlet weak var PhotoLibrary: UIButton!
    @IBOutlet weak var Post: UIButton!
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("heha")
        
        if(segue.identifier == "segueItemDetails"){
            print("here")
            //let image = UIImage()
            let DestViewController = segue.destinationViewController as! ItemDetail
            //self.image = DestViewController.tempUI
            DestViewController.tempUI = self.image!
            
            //let tempImage = UIImage()
            //DestViewController.itemImageView.image = UIImage()
            //DestViewController.itemImageView.image = image
            //itemImageView.image = image
            
        }
        
    }
    
    
    // this function is triggered when user presses post on the app. 
    
    @IBAction func PostAction(sender: UIButton) {
        
        //self.presentedViewController(capturedImage.image, animated: true, completion: nil)
        //self.presentViewController(UIVie, animated: <#T##Bool#>, completion:
        //presentViewController(PhotoViewController() as UIViewController, animated: true, completion: nil)
        print("in post button")
        //performSegueWithIdentifier("segueItemDetails", sender: self)
        
        
//        print("[PostAction] hey");
//        
//        let picBase64 = self.base64Image;
//        let description = "test description of item"
//        let price = 11235
//        let imageInfo = ["description" : description, "price" : price, "pic_base64" : picBase64, "owner_id" : "authData.uid"] // value for image uploaded
//        
//        let imageRef = ref.childByAppendingPath("items_for_sale");
//        let imageIDref = imageRef.childByAutoId()  // this generates a unique ID each time it is called. When can then use this to find the image later on. Note that this is now the ref that we will update
//        
//        imageIDref.updateChildValues(imageInfo as! [NSObject : AnyObject]) // this updates the DB
    }
    
    
    
    @IBAction func PhotoLibraryAction(sender: UIButton) {
        
        print("[PhotoLibraryAction] hi");
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion: nil)

    }
    
    @IBOutlet weak var ImageDisplay: UIImageView!
    
    
    //this function is trigered when a picture is selected from the photo library.
    // The function encodes the selected picture to base64 and sets the global variable 
    // base64image to hold the encoded data of the image that is selected

    
    
        //commenting out commenting out ======================///
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
//    {
//        ImageDisplay.image=info[UIImagePickerControllerOriginalImage]as?UIImage;dismissViewControllerAnimated(true, completion: nil)
//        
//        print("[imagePickerController] hi");
//        
//        
//        
//        
//        
//        
//        // this stores the UIImage object in var image.
//        let image : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage;
//        let imageData = UIImagePNGRepresentation(image);
//        
//        
//        // this encodes correctly
//         self.base64Image = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength);
//    }
    
    
    
    //===================== NEW FUNCTION =======================//
    //===================== NEW FUNCTION =======================//
    //===================== NEW FUNCTION =======================//
    
    func imagePickerController(picker:UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("in image picker controller")
        
        //info is a dictionary that has lots of metadata on the image that you pick
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        self.image = chosenImage
        capturedImage.contentMode = .ScaleAspectFit //3
        capturedImage.image = chosenImage //4
        dismissViewControllerAnimated(true, completion: nil) //5
        
        performSegueWithIdentifier("segueItemDetails", sender: self)
        
        //let chosenImage: UIImage = ([UIImagePickerControllerOriginalImage]as?UIImage)!;dismissViewControllerAnimated(true, completion: nil)
        //self.capturedImage.image = chosenImage
        //picker.dismissViewControllerAnimated(true, completion: { _ in })
    }
    
    
    //===================== NEW FUNCTION =======================//
    //===================== NEW FUNCTION =======================//
    //===================== NEW FUNCTION =======================//
    
    
    
    //===================== NEW FUNCTION =======================//
    //===================== NEW FUNCTION =======================//
    //===================== NEW FUNCTION =======================//
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: { _ in })
    }
    
    
    //===================== NEW FUNCTION =======================//
    //===================== NEW FUNCTION =======================//
    //===================== NEW FUNCTION =======================//

    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
    }
}
