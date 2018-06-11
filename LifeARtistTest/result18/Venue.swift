//
//  Venue.swift
//  DucTran-MapKit
//
//  Created by Duc Tran on 9/10/17.
//  Copyright © 2017 Duc Tran. All rights reserved.
//

import MapKit
import AddressBook
import SwiftyJSON

class Venue: NSObject, MKAnnotation
{
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    // test
    let name:String?
    
    init(title: String, locationName: String?,name: String, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.name=name
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    class func from(json: JSON) -> Venue?
    {
        var title: String
        if let unwrappedTitle = json["name"].string {
            title = unwrappedTitle
        } else {
            title = ""
        }
        // tesssttt
        var name: String
        if let unwrappedname = json["phone"].string {
            name = unwrappedname
        } else {
            name = ""
        }
        
        
        
        
        
        let locationName = json["location"]["address"].string
        let lat = json["location"]["lat"].doubleValue
        let long = json["location"]["lng"].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        return Venue(title: title, locationName: locationName, name: name,coordinate: coordinate)
    }
   
    
    
    func mapItem() -> MKMapItem
    {
        let addressDictionary = [String(kABPersonAddressStreetKey) : subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = "\(title) \(subtitle)\(name)"
       
        return mapItem
    }
}











