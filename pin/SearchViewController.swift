//
//  SearchViewController.swift
//  pin
//
//  Created by Sarah Zhou on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var searchBar = UISearchBar()
    var tableSearch = UITableView()
    var filteredData: [String]!
    var cell = PinCell()
    
    let cellReuseIdentifier = "pinCell"
    
    let data = ["Pin 1, Description 1", "Pin 2, Description2", "Pin 3, Description 3", "Pin 4, Description 4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        self.navigationController?.navigationBarHidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpViews() {
        
        filteredData = data
        
        view.backgroundColor = UIColor.whiteColor()
        
        tableSearch.dataSource = self
        tableSearch.registerClass(PinCell.self, forCellReuseIdentifier: "pinCell")
        tableSearch.rowHeight = 94
        tableSearch.delegate = self
        
        searchBar.delegate = self
        searchBar.frame = CGRect(x: 0, y: 20, width: 375, height: 44)
        searchBar.barTintColor = UIColor.orangeColor()
        searchBar.placeholder = "Search pins..."
        tableSearch.frame = CGRect(x: 0, y: 64, width: 375, height: 559)
        
        view.addSubview(searchBar)
        view.addSubview(tableSearch)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! PinCell
        let details = filteredData[indexPath.row].componentsSeparatedByString(", ")
        cell.pinNameLabel.text = details.first
        cell.descriptionLabel.text = details.last
        cell.ivPin.image = UIImage (named:"logo")
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowDetailVC", sender: nil)
    }
}
