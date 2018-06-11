//
//  regesterViewController.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 5/12/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import LocationPicker
import CoreLocation
import MapKit
import DropDown
import Alamofire
import SwiftyJSON


class regesterViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate {

    @IBOutlet var fullname: UITextField!
    @IBOutlet var usernaem: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var Imageimg: UIImageView!
    @IBOutlet var namecompany: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var number: UITextField!
    @IBOutlet var place: UITextField!
    @IBOutlet var info: UITextField!
    
    @IBAction func Login1Enter(_ sender: UIButton) {
        
        guard let  username = usernaem.text?.trimmed, !username.isEmpty, let fullname = fullname.text?.trimmed,!fullname .isEmpty, let email = email.text?.trimmed,!email.isEmpty, let password = password.text, !password.isEmpty,let Number = number.text?.trimmed, !Number.isEmpty  else { return }
        
        
        APIService.registerProvider(fullName: fullname, userName: username, email: email, password: password, Number: Number, image:Imageimg.image!, about: info.text!, address: place.text!, lat: lat, long: long, tradeName:namecompany.text! ){
            (_ error: Error?, _ success:Bool) in
            if success {
                print("welcome to our app")
            }else{
                print("x")
            }
            
            
            
        }
        
    }

    
    
    
    @IBAction func importImage(_ sender: Any) {
        let imagepickercontrller = UIImagePickerController()
        imagepickercontrller.delegate = self
        
        let actionsheet = UIAlertController(title:"photo source" , message: "chosse a source" , preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagepickercontrller.sourceType = .camera
                self.present(imagepickercontrller, animated: true, completion: nil)
                
            }else{
                print("camera not availble")
            }
            
        }))
        actionsheet.addAction(UIAlertAction(title: "photo Libarary", style: .default, handler: { (action:UIAlertAction) in
            imagepickercontrller.sourceType = .photoLibrary
            self.present(imagepickercontrller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        
        self.present(actionsheet, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        Imageimg.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    var locationString:String="location"
    
    let picker = UIDatePicker()
    let picker2 = UIDatePicker()
    
    
    @IBOutlet var selectPlace: UIButton!
    var SelcetString:String="location"
    var lat=""
    var long=""
    var locati:CLLocationDegrees?
    var lati:CLLocationDegrees?
    var location: Location? {
        didSet {
            //            locationNameLabel.text = location.flatMap({ $0.title }) ?? "No location selected"
            let loc=location.flatMap({ $0.title }) ?? "Location"
            
            selectPlace.setTitle(loc,for: .normal)
            self.locationString=loc
            
            print(location?.coordinate.latitude)
            locati=location?.coordinate.latitude
            lat=String(describing: locati)
            
            long=String(describing: location?.coordinate.longitude)
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        location = nil
        
        
        self.fullname.delegate = self
        self.usernaem.delegate = self
        self.email.delegate = self
        self.password.delegate = self
        self.namecompany.delegate = self
        self.place.delegate = self
        self.number.delegate = self
        self.info.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillchange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillchange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillchange(notification:)
            ), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
    }
    
    @objc func keyboardwillchange(notification:Notification){
        print("keyboardwillshow: \(notification.name.rawValue)")
        view.frame.origin.y = 0
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationpicker1" {
            let locationPicker = segue.destination as! LocationPickerViewController
            locationPicker.location = location
            locationPicker.showCurrentLocationButton = true
            locationPicker.useCurrentLocationAsHint = true
            locationPicker.selectCurrentLocationInitially = true
            
            locationPicker.completion = { self.location = $0 }
        }
        if segue.identifier == "toResult"{
            segue.destination as! ResultVC
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}
