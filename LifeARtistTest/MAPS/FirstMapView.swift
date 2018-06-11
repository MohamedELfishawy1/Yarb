//
//  FirstMapView.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/24/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//
import UIKit
import MapKit
import SwiftyJSON
import Alamofire
import Cosmos
class FirstMapView: UIViewController
{
    @IBOutlet weak var mapView: MKMapView!
    
    var venueModel:profileMap?
    
    
    
    var venues = [profileMap]()
    
//    func fetchData()
//    {
//        let fileName = Bundle.main.path(forResource: "Venues", ofType: "json")
//        let filePath = URL(fileURLWithPath: fileName!)
//        var data: Data?
//        do {
//            data = try Data(contentsOf: filePath, options: Data.ReadingOptions(rawValue: 0))
//        } catch let error {
//            data = nil
//            print("Report error \(error.localizedDescription)")
//        }
//        
//        if let jsonData = data {
//            let json = JSON(data: jsonData)
//            if let venueJSONs = json["response"]["venues"].array {
//                for venueJSON in venueJSONs {
//                    if let venue = profileMap.from(json: venueJSON) {
//                        self.venues.append(venue)
//                    }
//                }
//            }
//        }
//    }
//
    
    //new
        func fetchData()
        {
          
            
            
            
            
            let url = "http://live-artists.com/admin/api/show/provider/locations"
           
            let parameters = [
                "lat": 21.21312,
                "long": 22.2121
            ]

            Alamofire.request(url,method: .post, parameters: parameters,encoding: URLEncoding.default, headers: nil)
                .responseJSON { response in
                    
                    switch response.result
                    {
                    case .failure(let error):
                        
                        print(error)
                        
                    case .success(let value):
                        
                        
                        
                        let json = JSON(value)
                        print(json)
           
            
                        for venueJSON in json.array!{
                            
                            
                        if let venue = profileMap.from(json: venueJSON) {
                            self.venues.append(venue)
                        }
                    }
                }
        }
                    
            }
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//            let initialLocation = CLLocation(latitude: 21.21312, longitude: 22.2121)
//         zoomMapOn(location: initialLocation)
        
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
    var currentLocation: CLLocation!
    func checkLocationServiceAuthenticationStatus()
    {
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
          currentLocation = locationManager.location
//            print(currentLocation.coordinate.latitude)
//            print(currentLocation.coordinate.longitude)
          
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
        }
    }
}

extension FirstMapView : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last!
       
       
        
        self.mapView.showsUserLocation = true
    
        zoomMapOn(location: location)
    }
}

extension FirstMapView : MKMapViewDelegate
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
                view.canShowCallout = false
                // view.calloutOffset = CGPoint(x: -10, y:10)//x: -5, y: 5
                //  view.rightCalloutAccessoryView = UIButton(type: .contactAdd) as UIView
                //                let image = UIImage(named:"Home-49")
                //                let button=UIButton(type: .custom)
                //                button.frame=CGRect(x: 0, y: 0, width: 30, height: 30)
                //                button.setImage(image, for: UIControlState())
                //
                //                view.rightCalloutAccessoryView=button
                
                //.detailDisclosure
            }
            
            return view
        }
        
        return nil
    }
    
    
    //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //        if annotation is MKUserLocation
    //        {
    //            return nil
    //        }
    //        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
    //        if annotationView == nil{
    //            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
    //            annotationView?.canShowCallout = false
    //        }else{
    //            annotationView?.annotation = annotation
    //        }
    //        annotationView?.image = UIImage(named: "starbucks")
    //        return annotationView
    //    }
    
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
            //let dist:details=segue.destination as! details
            // dist.viaSegue=venueModel?.title
            
            
            
        }
    }
    
    
    
    
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView)
    {
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        // 2
        let starbucksAnnotation = view.annotation as! profileMap
        let views = Bundle.main.loadNibNamed("profile", owner: nil, options: nil)
        let calloutView = views?[0] as! userProfile
        //  calloutView.Name.text = starbucksAnnotation.name
        calloutView.cosmosView.rating = starbucksAnnotation.rate
        calloutView.Name.text = starbucksAnnotation.name
        
        //        calloutView.starbucksImage.image = starbucksAnnotation.
        //        let button = UIButton(frame: calloutView.starbucksPhone.frame)
        //        button.addTarget(self, action: #selector(ViewController.callPhoneNumber(sender:)), for: .touchUpInside)
        //        calloutView.addSubview(button)
        // 3
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    
 
}
