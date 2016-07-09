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
    var bio: String?
    var pins: [Pin]?
}
