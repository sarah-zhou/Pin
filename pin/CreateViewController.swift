//
//  CreateViewController.swift
//  pin
//
//  Created by Sarah Zhou on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    
    var navLabel = UILabel()
    var titleField = UITextField()
    var descriptionField = UITextField()
    var cameraImage = UIImageView()
    var cameraLabel = UILabel()
    var UploadImage = UIImageView()
    var chooseButton = UIButton()
    var takeButton = UIButton()
    var tagField = UITextField()
    var postButton = UIButton()
    var cancelButton = UIButton()
    
    
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

        navLabel.frame = CGRect(x: 0, y: 20, width: 375, height: 40)
        titleField.frame = CGRect(x: 20, y: 68, width: 335, height: 30)
        descriptionField.frame = CGRect(x: 20, y: 101, width: 335, height: 123)
        cameraImage.frame = CGRect(x: 134, y: 279, width: 113, height: 109)
        cameraLabel.frame = CGRect(x: 90, y: 233, width: 201, height: 201)
        UploadImage.frame = CGRect(x: 88, y: 232, width: 203, height: 203)
        chooseButton.frame = CGRect(x: 72, y: 442, width: 100, height: 30)
        takeButton.frame = CGRect(x: 302, y: 442, width: 100, height: 30)
        tagField.frame = CGRect(x: 20, y: 499, width: 335, height: 30)
        postButton.frame = CGRect(x: 12, y: 551, width: 350, height: 30)
        cancelButton.frame = CGRect(x: 12, y: 589, width: 350, height: 30)
        
        navLabel.textAlignment = NSTextAlignment.Center
        navLabel.textColor = UIColor.blackColor()
        navLabel.font = navLabel.font.fontWithSize(20.0)
        
        titleField.placeholder = "Add a title..."
        descriptionField.placeholder = "Add a description..."
        tagField.placeholder = "Add tags..."
        
        chooseButton.setTitle("Choose Photo", forState: UIControlState.Normal)
        chooseButton.titleLabel?.font = chooseButton.titleLabel?.font.fontWithSize(17.0)
        chooseButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        chooseButton.backgroundColor = UIColor.clearColor()
        
        takeButton.setTitle("Take Photo", forState: UIControlState.Normal)
        takeButton.titleLabel?.font = takeButton.titleLabel?.font.fontWithSize(17.0)
        takeButton.setTitleColor(UIColor.blackColor()(), forState: UIControlState.Normal)
        takeButton.backgroundColor = UIColor.clearColor()
        
        postButton.setTitle("Post", forState: UIControlState.Normal)
        postButton.titleLabel?.font = postButton.titleLabel?.font.fontWithSize(17.0)
        postButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        postButton.layer.cornerRadius = 20.0
        postButton.layer.borderWidth = 1.0
        postButton.layer.borderColor = UIColor.blackColor().CGColor
        
        cancelButton.setTitle("Post", forState: UIControlState.Normal)
        cancelButton.titleLabel?.font = postButton.titleLabel?.font.fontWithSize(17.0)
        cancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cancelButton.layer.cornerRadius = 20.0
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.borderColor = UIColor.blackColor().CGColor
        
        postButton.addTarget(self, action: #selector(onPost), forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.addTarget(self, action: #selector(onCancel), forControlEvents: UIControlEvents.TouchUpInside)
       
        view.addSubview(navLabel)
        view.addSubview(titleField)
        view.addSubview(descriptionField)
        view.addSubview(cameraImage)
        view.addSubview(cameraLabel)
        view.addSubview(UploadImage)
        view.addSubview(chooseButton)
        view.addSubview(takeButton)
        view.addSubview(tagField)
        view.addSubview(postButton)
        view.addSubview(cancelButton)
    }
    
    func onPost(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    func onCancel(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
