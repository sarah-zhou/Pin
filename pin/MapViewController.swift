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

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var mapView = MKMapView()
    var locationManager: CLLocationManager!
    var userLocation: CLLocationCoordinate2D!

    
    func setUpView() {
        mapView.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpView()
        view.addSubview(mapView)
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        
        // user activated automatic authorization info mode
        var status = CLLocationManager.authorizationStatus()
        if status == .NotDetermined || status == .Denied || status == .AuthorizedWhenInUse {
            // present an alert indicating location authorization required
            // and offer to take the user to Settings for the app via
            // UIApplication -openUrl: and UIApplicationOpenSettingsURLString
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        
        
        if status == .AuthorizedWhenInUse ||  status == .AuthorizedAlways {
            userLocation = locationManager.location!.coordinate
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            
            //mapview setup to show user location
            let region = MKCoordinateRegionMake(userLocation, MKCoordinateSpanMake(0.1, 0.1))
            mapView.setRegion(region, animated: false)
            
            mapView.delegate = self
            mapView.showsUserLocation = true
            mapView.mapType = MKMapType(rawValue: 0)!
            mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
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
        print("present location : \(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)")
    
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}






