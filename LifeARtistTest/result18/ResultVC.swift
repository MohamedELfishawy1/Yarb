//
//  ResultVC.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/20/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
class ResultVC: UIViewController {
  
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var Table2: UITableView!
    
    var array:[ResultVCModel]=[]
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

     //  loadData()
        loadHalfData()
        
        
//        if Shared.shared.filterResult == "skip" {
//            print("skip")
//            loadSkipData()
//
//        }
//
//        else{
//            if Shared.shared.Result == "3"{
//            print("search")
//            print("3")
//                loadHalfData()
//            }else{
//                print("search")
//                print("5")
//                loadData()
//            }
//        }

    }

    
    // load skip Value
    
    
    func loadSkipData()  {
        
        let url = URLs.nowOrder
     
        
        
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[ResultVCModel]()
                    
                    let json = JSON(value)
                    print(json)
                    
                    if let dataArr = json["second_category"].array
                    {
                        
                        for dataArr in dataArr {
                            let ar=ResultVCModel()
                            if let name = dataArr ["found_item_ID"].string,
                                let photo = dataArr ["found_items"].string,
                                let id = dataArr["name"].string,
                                let service = dataArr["email"].string,
                                let rate = dataArr["mobile"].string
                                
                                
                            {
                                
                                ar.name=name
                                ar.photo=photo
                                ar.providerID=id
                               // ar.rate=rate
                               // ar.service=service
                            }
                            
                            
                            
                            
                            self.array.append(ar)
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                    
                    
                }
                
                
                
                
                
                
                
                
        }
        
    }
    
    //load 3 data only
    
    
    func loadHalfData()  {
        
        let url = "http://live-artists.com/admin/api/search/service/providers?page=1"
//       let location=Shared.shared.locationResult
//       let service=Shared.shared.serviceResult
//       let serv=Shared.shared.servResult
        
        
        
        /*
 `{"data":
         [{"id":6,"fullName":"bobo","username":"bahamovic","image":"\/public\/images\/20-01-18-05-4426907798_1726611207402019_22185334445731930_n.jpg","active":"1",
         "rate":4.60000000000000053290705182007513940334320068359375,"password":"ennn@gmail.com",
         "email":"bahaa@gmail.com","tradeName":"ennn@gmail.com","phone":"123132321","address":"ennn@gmail.com",
         "lat":"ennn@gmail.com","long":"ennn@gmail.com","about":"ennn@gmail.com","created_at":"2018-01-09 10:02:33","updated_at":"2018-02-07 12:44:01","rates_count":"3",
         
         "rates":[
         {"id":2,"rate":"5","user_id":"2","provider_id":"6","created_at":null,"updated_at":null},
           {"id":3,"rate":"4.5","user_id":"2","provider_id":"6","created_at":"2018-01-11 02:20:13","updated_at":"2018-01-11 02:20:13"},
         {"id":4,"rate":"4.3","user_id":"2","provider_id":"6","created_at":"2018-01-11 02:20:46","updated_at":"2018-01-11 02:20:46"}
                  ]
         ,
         "services":[
         {"id"2,"name":"bahamovic","description":"momo","servicetype_id":"1","provider_id":"6","price":"2.5","created_at":"2018-01-18 12:54:49","updated_at":"2018-02-07 12:13:52"},
         {"id"9,"name":"okokok","description":"ok","servicetype_id":"1","provider_id":"6","price":"122","created_at":null,"updated_at":null}
                     ]
         
         }
         ,{"id":52,"fullName":"ahmed ezzz","username":"eng ezzzzz","image":"\/public\/images\/20-01-18-08-17IMG_20180119_034147.jpg","active":"1","rate":2.833333333333333481363069950020872056484222412109375,"password":"123456","email":"mado@gmail.com","tradeName":"eng ezzzz","phone":"011546252070","address":"Passage of Heba, Ezbet Nafie, El-Basatin, Cairo Governorate, Egypt","lat":"29.98411225091273","long":"31.25271387398243","about":"iam providerr","created_at":"2018-01-18 14:58:57","updated_at":"2018-01-20 20:42:17","rates_count":"3",
         
         
         "rates":[
         {"id":5,"rate":"2","user_id":"3","provider_id":"52","created_at":"2018-01-15 10:31:50","updated_at":"2018-01-15 10:31:50"},
         {"id":6,"rate":"4","user_id":"3","provider_id":"52","created_at":"2018-01-21 12:39:21","updated_at":"2018-01-21 12:39:21"},
         {"id":7,"rate":"2.5","user_id":"17","provider_id":"52","created_at":"2018-01-21 18:53:00","updated_at":"2018-01-21 18:53:00"}
                ],
         "services":[
         {"id"3,"name":"o","description":"ok","servicetype_id":"1","provider_id":"52","price":"1000","created_at":"2018-01-20 02:16:51","updated_at":"2018-01-20 17:23:32"},
         {"id"5,"name":"okll","description":"plkp","servicetype_id":"1","provider_id":"52","price":"500","created_at":"2018-01-20 02:32:07","updated_at":"2018-01-20 02:33:19"},
         {"id"6,"name":"klpos","description":"klpo","servicetype_id":"1","provider_id":"52","price":"369852","created_at":"2018-01-20 02:39:14","updated_at":"2018-01-30 00:44:18"},
         {"id"7,"name":"klpo","description":"klpo","servicetype_id":"1","provider_id":"52","price":"369852","created_at":"2018-01-20 02:40:15","updated_at":"2018-01-20 02:40:15"},
         {"id"8,"name":"mkllko","description":"plko","servicetype_id":"1","provider_id":"52","price":"369822","created_at":"2018-01-20 02:41:36","updated_at":"2018-01-20 02:48:11"}
         ]}
         ]}

        
        */
        
        
        
        
        let parameters = [
        
            
            "serviceType":"1",
            "search":"ok"
            
//            "location":location,
//            "servise":service,
//            "serv":serv
            
            ]
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[ResultVCModel]()
                    let json = JSON(value)
                    print(json)
                    if let dataArr = json["data"].array
                    {
                        for dataArr in dataArr {
                            let ar=ResultVCModel()
                            if let name = dataArr ["username"].string,
                                let photo = dataArr ["image"].string,
                                let id = dataArr["id"].string
                            {
                                ar.name=name
                                ar.photo=photo
                                ar.providerID=id
                               
                               // ar.serviceName=service
                            }
                       
                            if let rat=dataArr["rates"].array{
                                for dataArr in rat{
                                    if let rate=dataArr["rate"].string,let ratee=Double(rate){
                                     ar.rate=ratee
                                     print(ratee)
                                }
                            }
                            }
                            if let serv=dataArr["services"].array{
                                for dataArr in serv{
                                    if let service=dataArr["name"].string,
                                        let price=dataArr["price"].string
                                    {
                                        ar.serviceName=service
                                        ar.servicePrice=price
                                        print(service)
                                        print(price)
                                    }
                                }
                                }
                            
                            self.array.append(ar)
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                    
                    
                }
                
                
                
                
                
                
                
                
        }
        
    }
    
    
    //load all Data
    func loadData()  {
        
        let url = URLs.nowOrder
       
        
        let location=Shared.shared.locationResult
        let service=Shared.shared.serviceResult
        let serv=Shared.shared.servResult
        let date=Shared.shared.dateResult
        let time=Shared.shared.timeResult
        
        let parameters = [
            
            "location":location,
            "servise":service,
            "serv":serv
            
        ]
        
       
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[ResultVCModel]()
                    
                    let json = JSON(value)
                    print(json)
                    
                    if let dataArr = json["second_category"].array
                    {
                        
                        for dataArr in dataArr {
                            let ar=ResultVCModel()
                            if let name = dataArr ["found_item_ID"].string,
                                let photo = dataArr ["found_items"].string,
                                let id = dataArr["name"].string,
                                let service = dataArr["email"].string,
                                let rate = dataArr["mobile"].string
                            
                                
                            {
                                
                                ar.name=name
                                print(name)
                                ar.photo=photo
                                ar.providerID=id
                               // ar.rate=rate
                               // ar.service=service
                            }
                            
                            
                            
                            
                            self.array.append(ar)
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                    
                    
                }
                
                
                
                
                
                
                
                
        }
        
    }
    
    
    
    
}

// MARK: - TableView

extension ResultVC:UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultVCCell", for: indexPath) as! ResultVCCell
     
                cell.prize.text=array[indexPath.row].servicePrice
                cell.service.text=array[indexPath.row].serviceName
                cell.cosmosView.text=array[indexPath.row].name
                cell.name.text=array[indexPath.row].name
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
    }
}




