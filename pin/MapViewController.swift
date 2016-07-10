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
    var pinButton = UIButton()
    
    
    func setUpView() {
        mapView.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        pinButton.setBackgroundImage(UIImage(named: "logo"), forState: UIControlState.Normal)
        pinButton.frame = CGRect(x: 128, y: 482, width: 60, height: 60)
        pinButton.addTarget(self, action: #selector(pinClicked), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpView()
        view.addSubview(mapView)
        view.addSubview(pinButton)
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
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
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            if let userLocation = locationManager.location?.coordinate {
                //userLocation = locationManager.location!.coordinate
                
                
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
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        var annotations = [mapView.userLocation, view.annotation!]
        mapView.showAnnotations(annotations, animated: true)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        userLocation = newLocation.coordinate
        print("present location : \(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)")
        
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
        var newPin = Pin.init(title: "Enter Pin Details", locationName: "", discipline: "", coordinate: userLocation)
        
        
        //SEGUE TO DETAIL VIEW
        mapView.addAnnotation(newPin as! MKAnnotation)
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        print("didChangeDragState")
        if newState == MKAnnotationViewDragState.Ending{
            let droppedAt = view.annotation?.coordinate
            print(droppedAt)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}






