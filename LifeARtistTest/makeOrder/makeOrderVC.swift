//
//  makeOrderVC.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/21/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import BEMCheckBox
class makeOrderVC: UIViewController {

    var array:[makeOrderModel]=[]
    var sumArray:[Int]=[]
    @IBOutlet weak var tableView: UITableView!
    
    var firstCategory:String?
    var sum:Int?

    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var pCodeTF: UITextField!
    
    
    let picker = UIDatePicker()
    let picker2 = UIDatePicker()
    
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    
    
    
    @IBAction func makeOrderButton(_ sender: Any) {
        
        guard let address = addressTF.text?.trimmed, !address.isEmpty ,let DATE=dateTF.text?.trimmed, !DATE.isEmpty ,let TIME = timeTF.text?.trimmed, !TIME.isEmpty,let total=sum,total != 0  else {
            return
        }
        makeOrder(total: total, date: DATE , time: TIME, address: address)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        createTimePicker()
        loadData()
        
    }
    

    
    
    func loadData()  {
        
        
        
        
        let providerID=23
        let url = "http://live-artists.com/admin/api/show/service/\(providerID)"
     
        
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[makeOrderModel]()
                    
                    let json = JSON(value)
                    print(json)
                    
                    if let dataArr = json["services"].array
                    {
                        
                        for dataArr in dataArr {
                            let ar=makeOrderModel()
                            if  let title = dataArr["servicetype"]["title"].string,
                                let price = dataArr["price"].string,
                                let providerID=dataArr["provider_id"].string,
                                let servicetype_id = dataArr ["servicetype_id"].string
                                
                            {
                                
                             
                                //ar.name=total
                              
                                ar.serviceTypeID=servicetype_id
                                ar.title=title
                                ar.price=price
                                ar.providerID=providerID
                            }
                            
                            
                            
                            
                            
                            self.array.append(ar)
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                    
                    
                }
                
                
                
                
                
                
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
      //

        
        
        
        // format date
        let formatter =  DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        formatter.dateFormat="dd-MM-yyyy"
        
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
        formatter.dateFormat="H"
        
        let timeString = formatter.string(from: picker2.date)
        
        timeTF.text="\(timeString)"
        self.view.endEditing(true)
    }
    
    
    
    
    //
    func makeOrder(total:Int,date:String,time:String,address:String){
      
        
        let url = "http://live-artists.com/admin/api/add/order"
        
        
        /*
         
         total21
         provider_id2
         user_id2
         active1
         old_date21
         date11-11-1991dsfs
         time2
         address17 st saaid el nagar
         disc_code
         services
         
         */
        
        // let providerId="23"
        
        let providerId=Shared.shared.providerId
        let userId=UserDefaults.standard.string(forKey: "userId")
        let parameters = [
            
          
            "total": total,
            "provider_id": providerId,
            "user_id": userId,
            "old_date": "21",
            "active": "1",
            "date": date,
            "time": time,
            "address": address,
            "disc_code": ""
            
            ] as [String : Any]
        
        
        Alamofire.request(url,method: .post, parameters: parameters,encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                  //  self.array=[addServiceModel]()
                    
                    let json = JSON(value)
                    print(json)
                    
                    
                    
                    /*
                     
                     `{"ServiceResponse":{"name":"bahamovic","provider_id":"23","price":"23","description":"bahamovic",
                     "servicetype_id":"1","updated_at":"2018-02-07 12:05:20","created_at":"2018-02-07 12:05:20","id":10},
                     "message_en":"successfule added","message_ar":"\u062a\u0645 \u0627\u0644\u0627\u0636\u0627\u0641\u0629 \u0628\u0646\u062c\u0627\u062d"}
                     
                     
                     
                     
                     */
                    
//                    if let dataArr = json["ServiceResponse"].array
//                    {
//
//                        for dataArr in dataArr {
//                            let ar=addServiceModel()
//
//                            if let message = dataArr["message_en"].string , message=="successfule added"{
//
//
//                                if let desc = dataArr["description"].string,
//                                    let name = dataArr ["name"].string,
//                                    let price = dataArr["price"].string
//
//
//                                {
//
//                                    ar.name=name
//
//                                    ar.desc=desc
//
//                                    ar.price=price
//                                    //
//                                }
//
//
//
//                            }
//
//
//
//
//
//
//                            self.array.append(ar)
//                        }
//
//                        self.tableView.reloadData()
//
//                    }
                    
                    
                }
                
                
                
                
                
                
        }
    }
    
    
    
    
    
    
    
    
    
    

    
}

// MARK: - TableView

extension makeOrderVC:UITableViewDataSource,UITableViewDelegate,BEMCheckBoxDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "makeOrderCell", for: indexPath) as! makeOrderCell
      
        
        let arr = array[indexPath.row].price
        cell.prize.text=array[indexPath.row].price
        cell.service.text=array[indexPath.row].title
        cell.delegate=self
       // cell.check.addTarget(self,action:#selector(didTap),for: .touchUpInside)
        
     
        
        return cell
    }
    func didTap(_ checkBox: BEMCheckBox){
        if checkBox.tag == 0{
            print("lost")
           // choose="lost"
        }
   
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
}
extension makeOrderVC:makeorderCellDelegate {
    func didTapCheck(price: String,providerId:String) {
        print(price)
        let prize=Int(price)
        sumArray.append(prize!)
        print(sumArray)
       
        sum = sumArray.reduce(0, +)
        print(sum)
        Shared.shared.providerId=providerId
    }
    
      
        
}

