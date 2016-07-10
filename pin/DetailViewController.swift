//
//  DetailViewController.swift
//  pin
//
//  Created by Rebecca Lee on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var imagePin = UIImageView()
    var nameLabel = UILabel()
    var descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    func setUpViews(){
        imagePin.frame = CGRect(x: 123, y: 20, width: 128, height: 128)
        imagePin.image = UIImage (named:"logo")
        
        nameLabel.frame = CGRect(x: 0, y: 156, width: 375, height: 21)
        descriptionLabel.frame = CGRect(x: 0, y: 178, width: 375, height: 21)
        
        view.addSubview(imagePin)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
