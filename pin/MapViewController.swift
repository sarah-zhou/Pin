//
//  MapViewController.swift
//  pin
//
//  Created by Sarah Zhou on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse
import ParseUI

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var mapView = MKMapView()
    var locationManager: CLLocationManager!
    var userLocation: CLLocationCoordinate2D!
    var location: CLLocation!
    var pinLocation: CLLocation!
    var pinButton = UIButton()
    var pinDidChange: Bool!
    
    var pins: [MKAnnotation]!
    var posts = [PFObject]()
    var post: PFObject!

    
    var status = CLLocationManager.authorizationStatus()

    
    func setUpView() {
        mapView.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        pinButton.setBackgroundImage(UIImage(named: "logo"), forState: UIControlState.Normal)
        pinButton.frame = CGRect(x: 128, y: 482, width: 60, height: 60)
        pinButton.addTarget(self, action: #selector(pinClicked), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        fetchPins()
        
        for post in posts {
            //var newPin = Pin.init(title: self.post["title"] as! String, locationName: self.post["locationName"] as! String, discipline: "", coordinate: self.post["location"].coordinate)
            
            let point = self.post["location"] as! PFGeoPoint
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude)
            self.mapView.addAnnotation(annotation)
            
            //pins.append(newPin)
        }
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        
        // user activated automatic authorization info mode
        if status == .NotDetermined || status == .Denied || status == .AuthorizedWhenInUse {
            // present an alert indicating location authorization required
            // and offer to take the user to Settings for the app via
            // UIApplication -openUrl: and UIApplicationOpenSettingsURLString
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        if status == .AuthorizedWhenInUse ||  status == .AuthorizedAlways {
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            if let userLocation = locationManager.location?.coordinate {
                //userLocation = locationManager.location!.coordinate
                location = locationManager.location
                
                //mapview setup to show user location
                let region = MKCoordinateRegionMake(userLocation, MKCoordinateSpanMake(0.1, 0.1))
                mapView.setRegion(region, animated: false)
                
                mapView.delegate = self
                mapView.showsUserLocation = true
                mapView.mapType = MKMapType(rawValue: 0)!
                mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
            }
            
        }
        
        setUpView()
        view.addSubview(mapView)
        view.addSubview(pinButton)
        
        if pins != nil {
            mapView.addAnnotations(pins)
        }
        
        pinDidChange = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchPins()
        
        var annotationQuery = PFQuery(className: "Pin")
        var currentLoc = PFGeoPoint(location: locationManager.location)
        annotationQuery.whereKey("location", nearGeoPoint: currentLoc, withinMiles: 10)
        annotationQuery.findObjectsInBackgroundWithBlock {
            (posts, error) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successful query for annotations")
                let posts = posts! as [PFObject]
                
                for post in posts {
                    //                    let point = post["location"] as! PFGeoPoint
                    //                    let annotation = MKPointAnnotation()
                    //                    annotation.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude)
                    //                    self.mapView.addAnnotation(annotation)
                    for post in posts {
                        let point = post["location"] as! PFGeoPoint
                        let coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude)
                        let newPin = Pin.init(title: post["title"] as! String, locationName: "", discipline: "", coordinate: coordinate)
                        self.mapView.addAnnotation(newPin)
                    }
                    
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error)")
            }
        }
        
        if pins != nil {
            mapView.addAnnotations(pins)
        }
        
        if status == .AuthorizedWhenInUse ||  status == .AuthorizedAlways {
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            if let userLocation = locationManager.location?.coordinate {
                //userLocation = locationManager.location!.coordinate
                location = locationManager.location
                
                //mapview setup to show user location
                let region = MKCoordinateRegionMake(userLocation, MKCoordinateSpanMake(0.1, 0.1))
                mapView.setRegion(region, animated: false)
                
                mapView.delegate = self
                mapView.showsUserLocation = true
                mapView.mapType = MKMapType(rawValue: 0)!
                mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
            }
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse ||  status == .AuthorizedAlways {
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    let region = MKCoordinateRegionMake(userLocation, MKCoordinateSpanMake(0.1, 0.1))
                    mapView.setRegion(region, animated: false)
                    mapView.delegate = self
                }
            }
        }
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        userLocation = newLocation.coordinate
        location = newLocation

        //print("present location : \(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)")
        
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? Pin {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                dequeuedView.draggable = true
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.draggable = true
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
    
    func pinClicked() {
        print("pin dropped")
        pinLocation = location
        var newPin = Pin.init(title: "", locationName: "", discipline: "", coordinate: pinLocation.coordinate)
        //mapView.addAnnotation(newPin as! MKAnnotation)

        //SEGUE TO DETAIL VIEW
        let vc = CreateViewController()
        vc.location = pinLocation
        vc.modalPresentationStyle = .FullScreen
        vc.modalTransitionStyle = .CoverVertical
        self.presentViewController(vc, animated: true, completion: nil)
        
        //mapView.removeAnnotation(newPin as! MKAnnotation)

        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        print("didChangeDragState")
        if newState == MKAnnotationViewDragState.Ending{
            let droppedAt = view.annotation?.coordinate
            print(droppedAt)
        }
    }
    
    func fetchPins() {
        // construct query
        let query = PFQuery(className: "Pin")
        //query.whereKey("author", equalTo: PFUser.currentUser()!)
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                self.posts = posts
                //self.ProfileCollectionView.reloadData()
                
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        var annotationQuery = PFQuery(className: "Pin")
        var currentLoc = PFGeoPoint(location: locationManager.location)
        annotationQuery.whereKey("location", nearGeoPoint: currentLoc, withinMiles: 10)
        annotationQuery.findObjectsInBackgroundWithBlock {
            (posts, error) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successful query for annotations")
                let posts = posts! as [PFObject]
                
                for post in posts {
//                    let point = post["location"] as! PFGeoPoint
//                    let annotation = MKPointAnnotation()
//                    annotation.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude)
//                    self.mapView.addAnnotation(annotation)
                    for post in posts {
                        let point = post["location"] as! PFGeoPoint
                        let coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude)
                        let newPin = Pin.init(title: post["title"] as! String, locationName: "", discipline: "", coordinate: coordinate)
                        self.mapView.addAnnotation(newPin)
                    }
                    
                }
        
            } else {
                // Log details of the failure
                print("Error: \(error)")
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}






