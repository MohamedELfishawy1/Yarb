//
//  proiderNotificationVC.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/30/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class proiderNotificationVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
        
    /*
 
     "notifications": [
     {
     "id": 4,
     "text": "There is a new service from bahamovic",
     "text_ar": "يوجد خدمة جديدة من bahamovic",
     "user_id": "2",
     "order_id": "11",
     "rate_id": "1",
     "provider_id": "6",
     "created_at": "2018-01-17 02:31:37",
     "updated_at": "2018-01-17 02:31:37",
     "rate": null
     },
     {
     "id": 6,
     "text": "Service completed baham33ovic12312 and your rate 5",
     "text_ar": "تم الانتهاء من طلب baham33ovic12312 وتقيمك 5",
     "user_id": "3",
     "order_id": "1",
     "rate_id": "8",
     "provider_id": "6",
     "created_at": "2018-01-17 03:25:07",
     "updated_at": "2018-01-17 03:25:07",
     "rate": {
     "id": 8,
     "rate": "3",
     "user_id": "11",
     "provider_id": "13",
     "created_at": "2018-02-07 12:58:02",
     "updated_at": "2018-02-07 12:58:02"
     }

 
 
 */
        
        @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var tableview2: UITableView!
        var array:[notificationModel]=[]
        var arrayRate:[notificationModel]=[]
        
    
        
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            loadData()
            loadRateData()
            
            tableView.dataSource = self
            tableView.delegate = self
            tableview2.delegate=self
            tableview2.dataSource=self
            
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
           
            
            if(tableView == self.tableView){
                
                //   return arrayRate.count
                
                return array.count
                
            }
            else{
                return arrayRate.count
                
            }
            
            
        }
    
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            
            if(tableView == self.tableView){
                
                let  cell = tableView.dequeueReusableCell(withIdentifier: "PNOCell", for: indexPath) as! PNOCell
          
                
                
                
                let arr = array[indexPath.row]
                cell.setVideo(video: arr)
                cell.Title.text=array[indexPath.row].title
                cell.delegate = self
                
                return cell
                
            }
            else{
                let  cell = tableView.dequeueReusableCell(withIdentifier: "PNRCell", for: indexPath) as! PNRCell
                
                
                
                
                cell.Title.text=arrayRate[indexPath.row].title
                cell.cosmosView.rating=arrayRate[indexPath.row].rate
                
                
                
                
              
                
                
                return cell
                
            }
            
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 100
            
            }
            
        }
        
        
    
        
   
        
        
        func loadData()  {
            
            //let url = URLs.oldOrder
            
            
            
            
            // let userID=UserDefaults.standard.string(forKey: "userId")
           // http://live-artists.com/admin/api/show/provider/notific/6
            let userID=6
            
            let url = "http://live-artists.com/admin/api/show/provider/notific/\(userID)"
            
            
            
            
            Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
                .responseJSON { response in
                    
                    switch response.result
                    {
                    case .failure(let error):
                        
                        print(error)
                        
                    case .success(let value):
                        self.array=[notificationModel]()
                        
                        let json = JSON(value)
                        print(json)
                        
                        
                        /*
                         "id": 4,
                         "text": "There is a new service from bahamovic",
                         "text_ar": "يوجد خدمة جديدة من bahamovic",
                         "user_id": "2",
                         "order_id": "11",
                         "rate_id": "1",
                         "provider_id": "6",
                         "created_at": "2018-01-17 02:31:37",
                         "updated_at": "2018-01-17 02:31:37",
                         "rate": null
 
 
 
                       */
                        
                        
                        
                        
                        
                        if let dataArr = json["notifications"].array
                        {
                            
                            for dataArr in dataArr {
                                let ar=notificationModel()
                                
                                if dataArr["rate"].null != nil{
                                
                                if let providerId = dataArr ["provider_id"].string,
                                    let text = dataArr ["text"].string,
                                     let orderId = dataArr ["order_id"].string,
                                    let notificationID=dataArr["id"].int,
                                    let userId=dataArr["user_id"].string
                                {
                                    
                                    ar.service=providerId
                                    ar.title=text
                                    ar.orderId=orderId
                                    ar.notificationId=notificationID
                                    
                                }
                                }
                                
                                
                                self.array.append(ar)
                            }
                            
                            self.tableView.reloadData()
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                    
                    
            }
            
        }
        func loadRateData()  {
            
            //let url = URLs.oldOrder
            
            
            // let userID=UserDefaults.standard.string(forKey: "userId")
            
            /*
             
             
             
             */
            
            
            let userID=6
            
            let url = "http://live-artists.com/admin/api/show/provider/notific/\(userID)"
            
            
            
            
            Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
                .responseJSON { response in
                    
                    switch response.result
                    {
                    case .failure(let error):
                        
                        print(error)
                        
                    case .success(let value):
                        self.array=[notificationModel]()
                        
                        let json = JSON(value)
                        print(json)
                        
                        
                        
                        /*
                         
                         {
                         "id": 6,
                         "text": "Service completed baham33ovic12312 and your rate 5",
                         "text_ar": "تم الانتهاء من طلب baham33ovic12312 وتقيمك 5",
                         "user_id": "3",
                         "order_id": "1",
                         "rate_id": "8",
                         "provider_id": "6",
                         "created_at": "2018-01-17 03:25:07",
                         "updated_at": "2018-01-17 03:25:07",
                         "rate": {
                         "id": 8,
                         "rate": "3",
                         "user_id": "11",
                         "provider_id": "13",
                         "created_at": "2018-02-07 12:58:02",
                         "updated_at": "2018-02-07 12:58:02"
                         }
                    
                         
                        */
 
                        
                        
                        
                        
                        
                        
                        if let dataArr = json["notifications"].array
                        {
                            
                            

                            
                            for dataArr in dataArr {
                                let ar=notificationModel()
                                
                                if  let ratee=dataArr["rate"]["rate"].string{

                            
                                  if let text = dataArr ["text"].string
                                 
                                {
                                    
                                    
                                    ar.title=text
                                    ar.rate=Double(ratee)!
                                    print(ratee)
                                    
                                }
                                }
                                self.arrayRate.append(ar)
                            }
                            
                            self.tableview2.reloadData()
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                    
                    
            }
            
        }
        
    func deleteCell(cell: UITableViewCell) {
        if let deletionIndexPath = tableView.indexPath(for: cell) {
            array.remove(at: deletionIndexPath.row)
            tableView.deleteRows(at: [deletionIndexPath], with: .automatic)
        }
    }
        
}

extension proiderNotificationVC:providerorderCellDelegate {
    func didTapAccept(orderID: String,notificationID:Int) {
        print(orderID)
        print("Accept")
       acceptOrder(orderID:orderID,notificationID:notificationID)
        
    }
    
    func didTapreject(orderID: String,notificationID:Int) {
        print(orderID)
        print("reject")
        cancelOrder(orderID: orderID, notificationID: notificationID)
    }
    
    
    
    
    func acceptOrder(orderID:String,notificationID:Int)  {
        
        
        // http://live-artists.com/admin/api/cancel/order/1/13
        
        /*
         `{"orders":
         {"id"1,"total":"25","active":"0","old_date":"2","date":"2018-08-05","services":"makeup;haircut","time":"5.6","address":"17 st","lat":null,"long":"","disc_code":"dgdfgerg","provider_id":"6","user_id":"2","created_at":"2018-01-15 01:02:25","updated_at":"2018-02-07 12:26:27",
         "provider":{"id":6,"fullName":"full","username":"bahamovic","image":"\/public\/images\/20-01-18-05-4426907798_1726611207402019_22185334445731930_n.jpg","active":"1","rate":"0","password":"123123","email":"bahaa@gmail.com","tradeName":"trade","phone":"123132321","address":"wuwuwuwuuw","lat":"13213232","long":"321332132","about":"adasdadasd","created_at":"2018-01-09 10:02:33","updated_at":"2018-02-06 15:59:50"}},"response":1}
         
         
         
         
         */
        
        
//        let providerID=6
//        let orderID=orderID
        print(orderID)
        
        let url = "http://live-artists.com/admin/api/cancel/order/\(orderID)/\(notificationID)"
        
        
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[notificationModel]()
                    
                    let json = JSON(value)
                    print(json)
                    
                    
                    
                    
                    if    let response = json["response"].int, response == 1{
                    print("accepted)")
                     //   self.tableView.reloadData()
                    
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
        }
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    func cancelOrder(orderID:String,notificationID:Int)  {
        
        
        // http://live-artists.com/admin/api/cancel/order/1/13
        
    
        
//
//        let providerID=13
//        let orderID=1
        
        
        print(orderID)
        print(notificationID)
        
        let url = "http://live-artists.com/admin/api/cancel/order/\(orderID)/\(notificationID)"
        
        
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[notificationModel]()
                    
                    let json = JSON(value)
                    print(json)
                    
                    
                   
                    
                    if    let response = json["response"].int, response == 1{
                        print("accepted)")
                      //  self.tableView.reloadData()
                        
                    }
                    
                    
                    
                    
                    
                   
                    
                    
                }
                
                
                
                
                
                
        }
        
    
    
        
        
        
        
        
        
        
        
    }
    
    
    
    
}




