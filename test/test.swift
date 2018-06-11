//
//  test.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 5/13/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import LocationPicker
import CoreLocation
import MapKit
import DropDown
import Alamofire
import SwiftyJSON

class test: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var tableview1: UITableView!
    @IBOutlet var tableview2: UITableView!
    @IBOutlet var Name: UITextField!
    @IBOutlet var prise: UITextField!
    @IBOutlet var popAlert: UIVisualEffectView!
    
    var items = [String]()
    var array:[serviceModel]=[]
    
    
    var serviceString:String="service"


    @IBAction func addking(_ sender: Any) {
        // chooseDropDown.show()
        // loadData2()
        tableview2.alpha=1
        self.tableview2.isHidden = !self.tableview2.isHidden
    }
    @IBOutlet var kind: UIButton!

    let aniDuration = 0.7
    
    @IBAction func Done(_ sender: Any) {
        
        if Name.text?.isEmpty == true {
            
        } else {
            items.append(Name.text!)
            
            
            UserDefaults.standard.set(items, forKey: "SavedData")
            tableview1.reloadData()
            
            //Show the pop-up with animation
            animatePopup(alpha: 0.0)
            
            //Re-set the text field for next use
            Name.text = ""
        }
    
        
        if prise.text?.isEmpty == true {
            
        } else {
            items.append(prise.text!)
            
            
            UserDefaults.standard.set(items, forKey: "SavedData")
           tableview1
            .reloadData()
            
            //Show the pop-up with animation
            animatePopup(alpha: 0.0)
            
            //Re-set the text field for next use
            prise.text = ""
            
        }
    }




    @IBAction func cancel(_ sender: Any) {
        animatePopup(alpha: 0.0)
        Name.text = ""
        
    }
    
    @IBAction func add(_ sender: Any) {
        popAlert.alpha = 1
    }

    





    override func viewDidLoad() {
        super.viewDidLoad()
        tableview1.delegate = self
        tableview1.dataSource = self

        if let data = UserDefaults.standard.value(forKey: "SavedData") as? [String] {
            
            //Yes, there is saved data and we are loading it to our array and then we reload the tableview to read again from the array after we updated its data
            items = data

        
        }
    }

    

    




    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "testcell", for: indexPath)as! testcell
        if tableView == self.tableview1 {
        
        
        
        cell.Name?.text = items[indexPath.row]
        cell.prise.text = items[indexPath.row]
        }
        
        if tableView == self.tableview2 {
            
            cell.title.text = items[indexPath.row]
            
        }
    
        
        
        
        
        
        
        
        return cell
    }




    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //Swipe to delete
        if editingStyle == .delete {
            //Remove that task from array
            self.items.remove(at: indexPath.row)
            UserDefaults.standard.set(items, forKey: "SavedData")
            UserDefaults.standard.synchronize()
            tableview1.reloadData()
        }
    }

        func animatePopup(alpha: CGFloat) {
            UIView.animate(withDuration: aniDuration) {
                self.popAlert.alpha = alpha
            }
        }
















}

