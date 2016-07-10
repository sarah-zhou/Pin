//
//  CreateViewController.swift
//  pin
//
//  Created by Sarah Zhou on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    
    var navLabel = UILabel()
    var titleField = UITextField()
    var descriptionField = UITextField()
    var cameraImage = UIImageView()
    var cameraLabel = UILabel()
    var uploadImage = UIImageView()
    var chooseButton = UIButton()
    var takeButton = UIButton()
    var postButton = UIButton()
    var cancelButton = UIButton()
    
    var location: CLLocation!
    var locationName: String!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpView(){
        
        view.backgroundColor = UIColor.whiteColor()
        
        titleField.delegate = self
        descriptionField.delegate = self
        
        navLabel.frame = CGRect(x: 0, y: 20, width: 375, height: 40)
        titleField.frame = CGRect(x: 20, y: 68, width: 335, height: 30)
        descriptionField.frame = CGRect(x: 20, y: 101, width: 335, height: 123)
        cameraImage.frame = CGRect(x: 136, y: 275, width: 109, height: 109)
        cameraLabel.frame = CGRect(x: 90, y: 229, width: 201, height: 201)
        uploadImage.frame = CGRect(x: 78, y: 217, width: 225, height: 225)
        chooseButton.frame = CGRect(x: 72, y: 442, width: 100, height: 30)
        takeButton.frame = CGRect(x: 203, y: 442, width: 100, height: 30)
        postButton.frame = CGRect(x: 12, y: 537, width: 350, height: 30)
        cancelButton.frame = CGRect(x: 12, y: 580, width: 350, height: 30)
        
        navLabel.textAlignment = NSTextAlignment.Center
        navLabel.textColor = UIColor.blackColor()
        navLabel.font = navLabel.font.fontWithSize(20.0)
        
        titleField.attributedPlaceholder = NSAttributedString(string: "Add a title...")
        
        descriptionField.placeholder = "Add a description..."
        descriptionField.font = UIFont(name: descriptionField.font!.fontName, size: 14)
        descriptionField.contentVerticalAlignment = UIControlContentVerticalAlignment.Top
        
        navLabel.text = "Create A Pin"
        
        cameraImage.image = UIImage(named: "Camera")
        
        cameraLabel.text = "+ choose photo from camera roll or open camera to take new photo"
        cameraLabel.textColor = UIColor.whiteColor()
        cameraLabel.numberOfLines = 0
        cameraLabel.textAlignment = NSTextAlignment.Center
        
        uploadImage.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.8)
        
        uploadImage.layer.masksToBounds = false
        uploadImage.layer.cornerRadius = uploadImage.frame.height/2
        uploadImage.clipsToBounds = true
        
        chooseButton.setTitle("Choose Photo", forState: UIControlState.Normal)
        chooseButton.titleLabel?.font = chooseButton.titleLabel?.font.fontWithSize(15.0)
        chooseButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        chooseButton.backgroundColor = UIColor.clearColor()
        
        takeButton.setTitle("Take Photo", forState: UIControlState.Normal)
        takeButton.titleLabel?.font = takeButton.titleLabel?.font.fontWithSize(15.0)
        takeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        takeButton.backgroundColor = UIColor.clearColor()
        
        postButton.setTitle("Post", forState: UIControlState.Normal)
        postButton.titleLabel?.font = postButton.titleLabel?.font.fontWithSize(17.0)
        postButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        postButton.layer.cornerRadius = 20.0
        postButton.layer.borderWidth = 1.0
        postButton.layer.borderColor = UIColor.blackColor().CGColor
        
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.titleLabel?.font = postButton.titleLabel?.font.fontWithSize(17.0)
        cancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cancelButton.layer.cornerRadius = 20.0
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.borderColor = UIColor.blackColor().CGColor
        
        chooseButton.addTarget(self, action: #selector(cameraRoll), forControlEvents: UIControlEvents.TouchUpInside)
        postButton.addTarget(self, action: #selector(onPost), forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.addTarget(self, action: #selector(onCancel), forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(navLabel)
        view.addSubview(titleField)
        view.addSubview(descriptionField)
        view.addSubview(cameraImage)
        view.addSubview(uploadImage)
        view.addSubview(cameraLabel)
        view.addSubview(chooseButton)
        view.addSubview(takeButton)
        view.addSubview(postButton)
        view.addSubview(cancelButton)
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
    }
    
    func onPost(){
        postUserPin(uploadImage.image, withTitle: titleField.text, withDescription: descriptionField.text, withCompletion: nil)
        uploadImage.image = nil
        titleField.text = nil
        descriptionField.text = nil
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onCancel(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func cameraRoll() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let size = CGSizeMake(500.0, 500.0)
            let resizedImage = resize(pickedImage, newSize: size)
            
            uploadImage.image = resizedImage
            uploadImage.layer.masksToBounds = false
            uploadImage.layer.cornerRadius = uploadImage.frame.height/2
            uploadImage.clipsToBounds = true
            cameraLabel.hidden = true
            cameraImage.hidden = true
            
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    func postUserPin(image: UIImage?, withTitle caption: String?, withDescription description: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let pin = PFObject(className: "Pin")
        
        // Add relevant fields to the object
        pin["media"] = getPFFileFromImage(image) // PFFile column type
        pin["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        pin["title"] = titleField.text
        pin["location"] = PFGeoPoint(location: location)
        pin["locationName"] = NSNull()
        pin["description"] = descriptionField.text
        
        // Save object (following function will save the object in Parse asynchronously)
        pin.saveInBackgroundWithBlock(completion)
    }

    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
}
