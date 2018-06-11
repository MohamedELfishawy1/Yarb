//
//  addServiceVC.swift
//  LifeARtistTest
//
//  Created by mohamed on 5/1/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class addServiceVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
     var array:[addServiceModel]=[]
   
    override func viewDidLoad() {
        super.viewDidLoad()

        loadServices()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            
            return array.count
            

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let  cell = tableView.dequeueReusableCell(withIdentifier: "addServiceCell", for: indexPath) as! addServiceCell
            cell.name.text=array[indexPath.row].name
            cell.price.text=array[indexPath.row].price
            cell.desc.text=array[indexPath.row].desc
     
            return cell
   
        
    }
    func loadServices(){
        
        //let url = URLs.oldOrder
        
      //  let providerId=UserDefaults.standard.string(forKey: "providerId")
        let providerID=23
        
        let url = "http://live-artists.com/admin/api/show/service/\(providerID)"
        
     
        
        
       
        
        
        Alamofire.request(url,method: .get,encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[addServiceModel]()
                    
                    let json = JSON(value)
                    print(json)
        
                    if let dataArr = json["services"].array
                    {
                        
                        for dataArr in dataArr
                        {
                            let ar=addServiceModel()
                            
                                
                                if let desc = dataArr["description"].string,
                                     let name = dataArr ["name"].string,
                                    let price = dataArr["price"].string
                                    
                                    
                                {
                                    
                                    ar.name=name
                                    
                                    ar.desc=desc
                                    
                                    ar.price=price
                                    //
                                }
                            
                            self.array.append(ar)
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                    
                    
                }
                
                
                
                
                
                
        }
    }

    func loadData(name:String,description:String,price:String,serviceId:String){
        
        //let url = URLs.oldOrder
        
        
        let providerID=6
        
        let url = "http://live-artists.com/admin/api/show/orderprovider/\(providerID)"
        
        
        /*
 
         name bahamovic
         description bahamovic
         servicetype_id 1
         provider_id 23
         price 23
 
 
        */
        
       // let providerId="23"
        
        let providerId=UserDefaults.standard.string(forKey: "providerId")
        let parameters = [
            
            //            "id": id!,
            "name": name,
            "description": price,
            "servicetype_id": serviceId,
            "provider_id": providerId,
            "price": price
            ]
        
        
        Alamofire.request(url,method: .post, parameters: parameters,encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[addServiceModel]()
                    
                    let json = JSON(value)
                    print(json)
                    
                    
                    
                    /*
 
                     `{"ServiceResponse":{"name":"bahamovic","provider_id":"23","price":"23","description":"bahamovic",
                     "servicetype_id":"1","updated_at":"2018-02-07 12:05:20","created_at":"2018-02-07 12:05:20","id":10},
                     "message_en":"successfule added","message_ar":"\u062a\u0645 \u0627\u0644\u0627\u0636\u0627\u0641\u0629 \u0628\u0646\u062c\u0627\u062d"}

 
 
 
                    */
                    
                    if let dataArr = json["ServiceResponse"].array
                    {
                        
                        for dataArr in dataArr {
                            let ar=addServiceModel()
                            
                            if let message = dataArr["message_en"].string , message=="successfule added"{
                            
                                
                                if let desc = dataArr["description"].string,
                                    let name = dataArr ["name"].string,
                                    let price = dataArr["price"].string
                               
                                    
                                {
                                    
                                    ar.name=name
                                    
                                    ar.desc=desc
                                 
                                    ar.price=price
//
                                }
                                
                                
                                
                            }
                          
                            
                            
                            
                            
                            
                            self.array.append(ar)
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                    
                    
                }
                
                
                
                
                
                
        }
    }
    
}
