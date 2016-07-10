//
//  SearchViewController.swift
//  pin
//
//  Created by Sarah Zhou on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var searchBar = UISearchBar()
    var tableSearch = UITableView()
    var filteredData: [String]!
    var cell = PinCell()
    var nameLabel: String = ""
    var descriptionLabel: String = ""
    var posts = [PFObject]()
    var post: PFObject!
    var selectedLocation: CLLocationCoordinate2D!
    var pinImageFromCell: UIImage!

    
    let cellReuseIdentifier = "pinCell"
    
    //let data = ["Pin 1, Description 1", "Pin 2, Description2", "Pin 3, Description 3", "Pin 4, Description 4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPins { (success: Bool, error: NSError?) in
            print(self.posts)
        }
        self.setUpViews()
        self.navigationController?.navigationBarHidden = true
        print("about to fetch pins")
        
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpViews() {
        
        //filteredData = data
        
        view.backgroundColor = UIColor.whiteColor()
        
        tableSearch.dataSource = self
        tableSearch.registerClass(PinCell.self, forCellReuseIdentifier: "pinCell")
        tableSearch.rowHeight = 94
        tableSearch.delegate = self
        
        searchBar.delegate = self
        searchBar.frame = CGRect(x: 0, y: 20, width: 375, height: 44)
        searchBar.barTintColor = UIColor.orangeColor()
        searchBar.placeholder = "Search pins..."
        tableSearch.frame = CGRect(x: 0, y: 64, width: 375, height: 550)
        
        view.addSubview(searchBar)
        view.addSubview(tableSearch)
        tableSearch.addSubview(cell)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("here")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("pinCell", forIndexPath: indexPath) as! PinCell
        if posts.count != 0 {
            let post = posts[indexPath.row] as! PFObject
            print("displaying post")
            print(post)
            
            cell.pinNameLabel.text = post["title"] as! String
            cell.descriptionLabel.text = post["description"] as! String
            let point = post["location"] as! PFGeoPoint
            cell.location = CLLocationCoordinate2DMake(point.latitude, point.longitude)
            
            
            let parsedImage = post["media"] as? PFFile
            cell.ivPin.file = parsedImage
            cell.ivPin.loadInBackground()
            
        }
        return cell

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchPins { (success: Bool, error: NSError?) in
            print(self.posts)
        }
    }
    
    
    func fetchPins(withCompletion completion: PFBooleanResultBlock?) {
        
        let pinQuery = PFQuery(className: "Pin")
        //pinQuery.whereKey("username" = currentUser.username)
        
        pinQuery.findObjectsInBackgroundWithBlock {
            (posts: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successful query for pins")
                
                print(posts)
                if let posts = posts {
                    self.posts = posts
                    self.posts = self.posts.reverse()
                    self.tableSearch.reloadData()
                    
                }
                else {
                    print(error?.localizedDescription)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableSearch.reloadData()
                })

            }
            else {
                // Log details of the failure
                print("Error: \(error)")
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count

    }
    
    
    /*
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        })
        if searchText.isEmpty {
            filteredData = data
        } else {
            // The user has entered text into the search box
            // Use the filter method to iterate over all items in the data array
            // For each item, return true if the item should be included and false if the
            // item should NOT be included
            filteredData = data.filter({(dataItem: String) -> Bool in
                // If dataItem matches the searchText, return true to include it
                if dataItem.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                    return true
                } else {
                    return false
                }
            })
        }
        tableSearch.reloadData()
    }
 */
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!;
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! PinCell!;
        
        //grab all of the info from the cell
        if (currentCell.pinNameLabel.text != ""){
        nameLabel = currentCell.pinNameLabel.text!
        }
        if (currentCell.descriptionLabel.text != ""){
        descriptionLabel = currentCell.descriptionLabel.text!
        }
        
        selectedLocation = currentCell.location
        
        pinImageFromCell = currentCell.ivPin.image
        
        //call perform
        performSegueWithIdentifier("ShowDetailVC", sender: self)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "ShowDetailVC") {
            
            // initialize new view controller and cast it as your view controller
            var viewController = segue.destinationViewController as! DetailViewController
            // your new view controller should have property that will store passed value
            viewController.pinLocation = selectedLocation
            viewController.titleStr = nameLabel
            viewController.descriptionStr = descriptionLabel
            viewController.imageFromCell = pinImageFromCell
        }
        
    }
    
}
