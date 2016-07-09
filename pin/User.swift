//
//  User.swift
//  pin
//
//  Created by Sarah Zhou on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit
import Parse

class User: PFUser {
    
    var profilePic: PFFile?
    var name: String?
    var bio: String?
    var pins: [Pin]?
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
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
