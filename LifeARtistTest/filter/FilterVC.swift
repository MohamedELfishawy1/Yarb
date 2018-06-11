//
//  FilterVC.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/16/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import LocationPicker
import CoreLocation
import MapKit
import DropDown
import Alamofire
import SwiftyJSON
class FilterVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let textField = UITextField()
     var array:[serviceModel]=[]
    
    @IBOutlet weak var tableView: UITableView!
    
    
//
//    //MARK: - DropDown's
//
//    let chooseDropDown = DropDown()
//
//
//    lazy var dropDowns: [DropDown] = {
//        return [
//
//            self.chooseDropDown
//
//        ]
//    }()
//    func setupDropDowns() {
//        setupChooseDropDown()
//
//    }
    
    
    
    var serviceString:String="service"
    var locationString:String="location"
    
//    func setupChooseDropDown() {
//        chooseDropDown.anchorView = service
//
//        // By default, the dropdown will have its origin on the top left corner of its anchor view
//        // So it will come over the anchor view and hide it completely
//        // If you want to have the dropdown underneath your anchor view, you can do this:
//        chooseDropDown.bottomOffset = CGPoint(x: 0, y: service.bounds.height)
//
//        // You can also use localizationKeysDataSource instead. Check the docs.
////        chooseDropDown.dataSource = [
////            "Lorem ipsum dolor",
////            "sit amet consectetur",
////            "cadipisci en..."
////        ]
//
//
//        // chooseDropDown.dataSource=array
//
//        // Action triggered on selection
//        chooseDropDown.selectionAction = { [weak self] (index, item) in
//            self?.service.setTitle(item, for: .normal)
//
//            self?.serviceString=item
//        }
//    }
    
    
    
    
    
    @IBAction func serviceButton(_ sender: Any) {
       // chooseDropDown.show()
       // loadData2()
        tableView.alpha=1
      self.tableView.isHidden = !self.tableView.isHidden
    }
    
    
//    func setupDefaultDropDown() {
//        DropDown.setupDefaultAppearance()
//
//        dropDowns.forEach {
//            $0.cellNib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownCell.self))
//            $0.customCellConfiguration = nil
//        }
//    }
    
    let picker = UIDatePicker()
    let picker2 = UIDatePicker()
    
    @IBOutlet weak var service: UIButton!
    @IBOutlet weak var locationNameButton: UIButton!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    
    @IBOutlet weak var textTF: UITextField!
    
    var location: Location? {
        didSet {
//            locationNameLabel.text = location.flatMap({ $0.title }) ?? "No location selected"
            let loc=location.flatMap({ $0.title }) ?? "Location"
          
             locationNameButton.setTitle(loc,for: .normal)
            self.locationString=loc
            
            print(location?.coordinate.latitude)
            print(location?.coordinate.longitude)

            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        location = nil
        createDatePicker()
        createTimePicker()
 //      tableView.delegate=self
//        tableView.dataSource=self
       loadData2()
//        dropDowns.forEach { $0.dismissMode = .onTap }
//        dropDowns.forEach { $0.direction = .any }
//        setupDropDowns()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LocationPicker" {
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

    // Date
    func createDatePicker(){
        // make toolbar
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        // done button
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonClick))
        toolbar.setItems([done], animated: false)
        
        dateTF.inputAccessoryView = toolbar
        dateTF.inputView=picker
        // format date
        picker.datePickerMode = .date
        
    }
    @objc func doneButtonClick(){
        // format date
        let formatter =  DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
        
        dateTF.text="\(dateString)"
        self.view.endEditing(true)
    }
    //time
    // Date
    func createTimePicker(){
        // make toolbar
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        // done button
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonClickTime))
        toolbar.setItems([done], animated: false)
        
        timeTF.inputAccessoryView = toolbar
        timeTF.inputView=picker2
        // format date
        picker2.datePickerMode = .time
        
    }
    @objc func doneButtonClickTime(){
        // format date
        let formatter =  DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        let timeString = formatter.string(from: picker2.date)
        
        timeTF.text="\(timeString)"
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func skipButton(_ sender: Any) {
       Shared.shared.filterResult = "skip"
        performSegue(withIdentifier: "toResult", sender: self)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
        Shared.shared.filterResult = "search"
      //  performSegue(withIdentifier: "toResult", sender: self)

        let DATE=dateTF.text!
        let TIME=timeTF.text!
        if DATE.isEmpty && TIME.isEmpty {
            guard serviceString != "service", locationString != "location" , let text=textTF.text,!text.isEmpty   else{
                return
            }
            
            
               Shared.shared.locationResult = locationString
               Shared.shared.serviceResult = serviceString
               Shared.shared.servResult = text
               Shared.shared.Result = "3"
               performSegue(withIdentifier: "toResult", sender: self)
           
        }
        else{
            guard serviceString != "service", locationString != "location" , let text=textTF.text,!text.isEmpty   else{
                return
            }
            
            
            Shared.shared.locationResult = locationString
            Shared.shared.serviceResult = serviceString
            Shared.shared.servResult = text
            Shared.shared.dateResult = DATE
            Shared.shared.timeResult = TIME
            Shared.shared.Result = "5"
            performSegue(withIdentifier: "toResult", sender: self)
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    func loadData2()  {
        
        
        let url = "http://live-artists.com/admin/api/get/servicetype"
        
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[serviceModel]()
                    
                    let json = JSON(value)
                    print(json)
                    if let dataArr = json["serviceType"].array
                    {
                        for dataArr in dataArr {
                            let ar=serviceModel()
                            if let id = dataArr ["id"].int,
                                let titl = dataArr ["title"].string
                                
                            {
                                ar.id=id
                                ar.title=titl
                                
                            }
                            
                            
                            
                            
                            self.array.append(ar)
                        }
                        
                        self.tableView.reloadData()
                    }
                    
                    
                }
                
                
                
                
                
                
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell=tableView.dequeueReusableCell(withIdentifier: "serviceCell", for: indexPath) as! serviceCell
        
        cell.title.text=array[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        service.setTitle(array[indexPath.row].title, for: .normal)
        print(array[indexPath.row].id)
        Shared.shared.filterService=Int(array[indexPath.row].id)
        tableView.isHidden=true
    }
}
