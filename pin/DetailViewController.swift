
//
//  DetailViewController.swift
//  pin
//
//  Created by Rebecca Lee on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse
import ParseUI

class DetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var imagePin = UIImageView()
    var nameLabel = UILabel()
    var descriptionLabel = UILabel()
    var mapView = MKMapView()

    var pinLocation: CLLocationCoordinate2D!
    var pinDidChange: Bool!
    
    var pinButton = UIButton()
    
    var pins: [MKAnnotation]!
    var posts = [PFObject]()
    var post: PFObject!

    var titleStr: String?
    var descriptionStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        setUpViews()
        
       print(pinLocation)
    }
    
    func setUpViews(){
        imagePin.frame = CGRect(x: 113, y: 68, width: 150, height: 150)
        imagePin.image = UIImage (named:"logo")
        
        nameLabel.frame = CGRect(x: 0, y: 226, width: 375, height: 21)
        nameLabel.text = titleStr
        nameLabel.textAlignment = NSTextAlignment.Center
        descriptionLabel.frame = CGRect(x: 0, y: 248, width: 375, height: 21)
        descriptionLabel.text = descriptionStr
        descriptionLabel.textAlignment = NSTextAlignment.Center
        descriptionLabel.textColor = UIColor.grayColor()
        
        mapView.delegate = self
        mapView.frame = CGRect(x: 0, y: 300, width: 375, height: 367)
        
        //pass in location and make pin at location
        mapView.setRegion(MKCoordinateRegionMake(pinLocation, MKCoordinateSpanMake(0.1, 0.1)), animated: false)
        let annotation = MKPointAnnotation()
      //  var locationCoordinate = pinLocation
        let locationCoordinate = pinLocation
        annotation.coordinate = locationCoordinate
        mapView.addAnnotation(annotation)

        view.addSubview(imagePin)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(mapView)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
