//
//  MapViewController.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/20/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class MapViewController: UIViewController
{
    @IBOutlet weak var mapView: MKMapView!
    
    var venueModel:Venue?
    
    
    
    var venues = [Venue]()
    
    func fetchData()
    {
        let fileName = Bundle.main.path(forResource: "Venues", ofType: "json")
        let filePath = URL(fileURLWithPath: fileName!)
        var data: Data?
        do {
            data = try Data(contentsOf: filePath, options: Data.ReadingOptions(rawValue: 0))
        } catch let error {
            data = nil
            print("Report error \(error.localizedDescription)")
        }
        
        if let jsonData = data {
//            let json = JSON(data: jsonData)
//            if let venueJSONs = json["response"]["venues"].array {
//                for venueJSON in venueJSONs {
//                    if let venue = Venue.from(json: venueJSON) {
//                        self.venues.append(venue)
//                    }
//                }
//            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let initialLocation = CLLocation(latitude: 37.7749, longitude: -122.431297)
        //        zoomMapOn(location: initialLocation)
        
        //        let sampleStarbucks = Venue(title: "Starbucks Imagination", locationName: "Imagination Street", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.431297))
        //        mapView.addAnnotation(sampleStarbucks)
        
        mapView.delegate = self
        fetchData()
        mapView.addAnnotations(venues)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkLocationServiceAuthenticationStatus()
    }
    
    private let regionRadius: CLLocationDistance = 1000 // 1km ~ 1 mile = 1.6km
    func zoomMapOn(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: - Current Location
    
    var locationManager = CLLocationManager()
    
    func checkLocationServiceAuthenticationStatus()
    {
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
}

extension MapViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last!
        self.mapView.showsUserLocation = true
        zoomMapOn(location: location)
    }
}

extension MapViewController : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if let annotation = annotation as? Venue {
            let identifier = "pin"
            //pin
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -10, y:10)//x: -5, y: 5
                //  view.rightCalloutAccessoryView = UIButton(type: .contactAdd) as UIView
                let image = UIImage(named:"Home-49")
                let button=UIButton(type: .custom)
                button.frame=CGRect(x: 0, y: 0, width: 30, height: 30)
                button.setImage(image, for: UIControlState())
                
                view.detailCalloutAccessoryView=button
                
                //.detailDisclosure
            }
            
            return view
        }
        
        return nil
    }
    
    
    // when click on annotion
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        // let location = view.annotation as! Venue
        
        //        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        //        location.mapItem().openInMaps(launchOptions: launchOptions)
        print(view.annotation?.coordinate)
        print(view.annotation?.subtitle)
        
        performSegue(withIdentifier: "go", sender:self)
        
        //
        //
        //        print("image number \(array[indexPath.row].id)")
        //        performSegue(withIdentifier: "go", sender: array[indexPath.row])
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "go"{
           // let dist:details=segue.destination as! details
            // dist.viaSegue=venueModel?.title
            
            
            
        }
    }
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        print("select")
        
        
    }
}






