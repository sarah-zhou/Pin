//
//  User.swift
//  pin
//
//  Created by Sarah Zhou on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class User: PFUser {
    
    var image: UIImage?
    var profilePic: PFFile?
    var name: String?
    var bio: String?
    var pins: [Pin]?
    var mail: String?
    
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    func postUserProfile(image: UIImage?, withName name: String?, withBio bio: String?, withPins pins: [Pin], withEmail mail: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let user = PFObject(className: "User")
        
        if name == "" {
            user["name"] = ""
        } else {
            user["name"] = name
        }
        
        if bio == "" {
            user["bio"] = ""
        } else {
            user["bio"] = bio
        }
        
        if mail == "" {
            user["mail"] = ""
        } else {
            user["mail"] = mail
        }

        if getPFFileFromImage(image) == nil {
            user["profilePic"] = ""
        } else {
            profilePic = getPFFileFromImage(image)
            user["profilePic"] = profilePic // PFFile column type
        }
            
        // Save object (following function will save the object in Parse asynchronously)
        user.saveInBackgroundWithBlock(completion)

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
                print("size: \(imageData.length)")
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
