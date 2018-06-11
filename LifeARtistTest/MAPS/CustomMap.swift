//
//  CustomMap.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/25/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import MapKit
import AddressBook
import SwiftyJSON
class CustomMap: NSObject , MKAnnotation
{
    let name: String?
    let service: String?
    let icon:String?
    let price:String?
    let coordinate: CLLocationCoordinate2D
    
    
    init(name: String, service: String?,icon: String,price: String, coordinate: CLLocationCoordinate2D)
    {
        self.name = name
        self.service = service
        self.coordinate = coordinate
        self.icon=icon
        self.price=price
        super.init()
    }
    
    var subtitle: String? {
        return name
    }
    
    class func from(json: JSON) -> CustomMap?
    {
        var name: String
        if let nname = json["name"].string {
            name = nname
        } else {
            name = ""
        }
        // tesssttt
        var service: String
        if let sservice = json["service"].string {
            service = sservice
        } else {
          service = ""
        }
        
        var price: String
        if let p = json["service"].string {
            price = p
        } else {
            price = ""
        }
        
        
        
        let icon = json["location"]["address"].string
        let lat = json["location"]["lat"].doubleValue
        let long = json["location"]["lng"].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
       
        return CustomMap(name: name, service: service, icon: icon!,price:price, coordinate: coordinate)
    }
    
    
    
    func mapItem() -> MKMapItem
    {
        let addressDictionary = [String(kABPersonAddressStreetKey) : subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = "\(name) \(service)\(icon) \(price)"
        
        return mapItem
    }
}



