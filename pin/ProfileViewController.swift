//
//  ProfileViewController.swift
//  pin
//
//  Created by Sarah Zhou on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var imageView = UIImageView()
    var nameLabel = UILabel()
    var usernameLabel = UILabel()
    var tablePins = UITableView()
    var cell = PinCell()
    var editButton = UIButton()
    // let navigationVC = UINavigationController(rootViewController: ProfileSettingsViewController)
    
    let cellReuseIdendifier = "pinCell"
    
    let data = ["Pin1, Description1", "Pin2, Description2", "Pin3, Description3"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpViews(){
        
        view.backgroundColor = UIColor.whiteColor()

        imageView.frame = CGRect(x: 123, y: 20, width: 128, height: 128)
        imageView.image = UIImage (named:"logo")
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        editButton.frame = CGRect(x: 320, y: 22, width: 50, height: 30)
        editButton.backgroundColor = UIColor.grayColor()
        editButton.setTitle("Edit", forState: .Normal)
        
        nameLabel.frame = CGRect(x: 0, y: 156, width: 375, height: 21)
        nameLabel.text = "Rebecca"
        nameLabel.textAlignment = NSTextAlignment.Center
        usernameLabel.frame = CGRect(x: 0, y: 178, width: 375, height: 21)
        usernameLabel.text = "@" + "beccawella"
        usernameLabel.textColor = UIColor.grayColor()
        usernameLabel.textAlignment = NSTextAlignment.Center
        
        tablePins.frame = CGRect(x: 0, y: 207, width: 375, height: 460)
        tablePins.delegate = self
        tablePins.dataSource = self
        tablePins.registerClass(PinCell.self, forCellReuseIdentifier: "pinCell")
        tablePins.rowHeight = 94
        //tablePins.estimatedRowHeight = 90
                
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(tablePins)
        view.addSubview(editButton)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdendifier, forIndexPath: indexPath) as! PinCell
        let details = data[indexPath.row].componentsSeparatedByString(", ")
        cell.pinNameLabel.text = details.first
        cell.descriptionLabel.text = details.last
        cell.ivPin.image = UIImage (named:"logo")

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func editProfile(sender: UIButton) {
        // self.presentViewController(self.navigationVC, animated: true, completion: nil)
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailViewController" {
            let button = sender as! UIButton
            let contentView = button.superview! as UIView
            let cell = contentView.superview as! PinCell
            let indexPath = tablePins.indexPathForCell(cell)
            let pin = data[indexPath!.row]
            
            //let detailViewController = segue.destinationViewController as! DetailViewController
            //detailViewController = pin
        }
    }*/
    
}








