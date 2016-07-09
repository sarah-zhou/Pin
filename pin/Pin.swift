//
//  Pin.swift
//  pin
//
//  Created by Sarah Zhou on 7/9/16.
//  Copyright © 2016 Sarah Zhou. All rights reserved.
//

import UIKit
import MapKit

class Pin: NSObject, MKAnnotation {

    var title: String!
    var locationName: String
    var discipline: String
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String! {
        return locationName
    }
    
    
    var photo: UIImage!
    

}
