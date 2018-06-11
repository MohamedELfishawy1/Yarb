//
//  profileMap.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/24/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import Foundation

import MapKit
import AddressBook
import SwiftyJSON

class profileMap: NSObject, MKAnnotation
{
    let name: String?
    let rate: Double
    let icon:String?
    let coordinate: CLLocationCoordinate2D
   
    
    init(name: String, rate: Double,icon: String, coordinate: CLLocationCoordinate2D)
    {
        self.name = name
        self.rate = rate
        self.coordinate = coordinate
        self.icon=icon
        super.init()
    }
    
    var subtitle: String? {
        return name
    }

    class func from(json: JSON) -> profileMap?
    {
        var name: String
        if let nname = json["username"].string {
            name = nname
              print(name)
        } else {
            name = ""
        }
      
        // tesssttt
        var rate: Double
        if let rrate = json["rate"].string {
            rate = Double(rrate)!
        } else {
            rate = 0
        }
        
        var ln:Double=0
        var lng:Double=0
        
        if let lat = json["lat"].string,let latt=Double(lat){
            ln=latt
        }
        if let long = json["long"].string,let lon=Double(long){
            lng=lon
        }
        
        let icon = json["image"].string
//        let lat = json["lat"].string
//        let long = json["long"].string
       // let latt=Double(lat)
        let coordinate = CLLocationCoordinate2D(latitude: ln, longitude: lng)
   
    
        return profileMap(name: name, rate: rate, icon: icon!, coordinate: coordinate)
    }
    
    
    
    func mapItem() -> MKMapItem
    {
        let addressDictionary = [String(kABPersonAddressStreetKey) : subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = "\(name) \(rate)\(icon)"
        
        return mapItem
    }
}











