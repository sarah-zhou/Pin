//
//  ReplaceRootVC.swift
//  pin
//
//  Created by Aashima Garg on 7/10/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit

class ReplaceRootVC: UIStoryboardSegue {
    override func perform() {
        
        (UIApplication.sharedApplication().delegate as? AppDelegate)?.window?.rootViewController = destinationViewController
    }
}
