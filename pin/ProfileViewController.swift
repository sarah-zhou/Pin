//
//  ProfileViewController.swift
//  pin
//
//  Created by Sarah Zhou on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource {
    
    var imageView : UIImageView!
    var nameLabel : UILabel!
    var tablePins: UITableView!
    var cell : PinCell!
    
    let data = ["Pin1, Description1", "Pin2, Description2", "Pin3, Description3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tablePins.dataSource = self
        setupViews();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews(){
        
        view.backgroundColor = UIColor.whiteColor()

        imageView.frame = CGRect(x: 107, y: 20, width: 160, height: 128)
        imageView.image = UIImage(named: "profile")
        nameLabel.frame = CGRect(x: 0, y: 164, width: 375, height: 21)
        tablePins.estimatedRowHeight = 44
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(tablePins)
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Pin Cell", forIndexPath: indexPath) as! PinCell
        let details = data[indexPath.row].componentsSeparatedByString(", ")
        cell.pinNameLabel.text = details.first
        cell.descriptionLabel.text = details.last
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}








