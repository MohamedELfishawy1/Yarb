//
//  userNotificationVC.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/25/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class userNotificationVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableview2: UITableView!
     var array:[userNotificationModel]=[]
     var arrayRate:[userNotificationModel]=[]
    
    
//
//    let houseData = ["Arryn", "Baratheon", "Greyjoy", "Lannister", "Martell", "Stark", "Targaryen", "Tully", "Tyrell"]
//
//
//
//    let wordsData = ["As high as honor", "Ours is the fury", "We do not sow", "Hear me roar", "Unbowed, unbent, unbroken", "Winter is coming", "fire and blood", "Family, duty, honor", "Growing strong"]
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.dataSource = self
        tableView.delegate = self
        tableview2.delegate=self
        tableview2.dataSource=self
        loadData()
        loadRateData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
//        var count:Int?
//
//        if tableView == self.tableView {
//            count = houseData.count
//        }
//
//        if tableView == self.tableview2 {
//            count =  wordsData.count
//        }
//
//        return count!
  
        if(tableView == self.tableView){
            
           return arrayRate.count
            
            //return houseData.count
            
        }
        else{
           // return wordsData.count
            return array.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(tableView == self.tableView){
            
            let  cell = tableView.dequeueReusableCell(withIdentifier: "UNR", for: indexPath) as! UNR
                      cell.textt.text=arrayRate[indexPath.row].text
                      cell.proID.text=arrayRate[indexPath.row].providerId
                      cell.delegate=self
            
            // Store the star's rating when user lifts her finger
            cell.cosmosView.didFinishTouchingCosmos = { [weak self] rating in

             //  cell.id.text=String(rating)
               self?.addRate(rate:rating,provId:"k")

        }
            
                   return cell
            
        }
        else{
            let  cell = tableView.dequeueReusableCell(withIdentifier: "UNL", for: indexPath) as! UNL
                     cell.Title.text=array[indexPath.row].text
          
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
        
        
        
        
    }
    

    
    
    
    
    
    func addRate(rate:Double,provId:String)  {
        print(rate)
        print(provId)
        
        
        /*
        rate 3
        provider_id 13
        user_id 11
        */
        
        
        // let userID=UserDefaults.standard.string(forKey: "userId")
        
        
        
        
        print(rate)
        print(provId)
        
        let url = "http://live-artists.com/admin/api/add/rate"
        
        let parameters = [
            
         
            "rate": rate,
            "provider_id": provId,
            "user_id": 120
            
            ] as [String : Any]
        
        
        Alamofire.request(url, method: .post,parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[userNotificationModel]()
                    
                    let json = JSON(value)
                    print(json)
                    
                    
                    
                    /*
 
                     `{"rateResponse":
                     {"rate":"3","user_id":"11","provider_id":"13","updated_at":"2018-02-07 12:58:02","created_at":"2018-02-07 12:58:02","id":8,
                     "user":
                     {"id":11,"firstName":"bahamovic","lastName":"lashin","fullName":"bahamovic lashin","email":"bullet@gmail.com","phone":"01060060097","active":"1","type_id":"3","password":"$2y$10$E7PBxBVPXsZHjabcOFvSdOUJCowMaoq7JXuTZonWjhhHHLtyXJ14S","created_at":"2018-01-18 10:08:28","updated_at":"2018-02-06 16:19:40"}}}

                    */
                    
                    
                    
                    
                    
                  
                    
                    
                }
                
                
                
                
                
                
        }
        
        
        
        
    }
    

    
    
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DetailVC()
//        vc.commonInit("got_bg_\(indexPath.item)", title: houseData[indexPath.item])
//        self.navigationController?.pushViewController(vc, animated: true)
//        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func loadData()  {
        
        //let url = URLs.oldOrder
        
        
        
        
       // let userID=UserDefaults.standard.string(forKey: "userId")
        
        let userID=120
        
        let url = "http://live-artists.com/admin/api/show/user/notific/\(userID)"
        
        
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[userNotificationModel]()
                    
                    let json = JSON(value)
                    print(json)
                    
                    if let dataArr = json["notifications"].array
                    {
                        
                        for dataArr in dataArr {
                            let ar=userNotificationModel()
                            if let type=dataArr["type"].string,type == "1" {
                                if let providerId = dataArr ["provider_id"].string,
                                    let text = dataArr ["text"].string
                                {
                                    
                                    ar.providerId=providerId
                                    ar.text=text
                                 
                                }
                            
                            }
                            self.array.append(ar)
                        }
                        
                        self.tableview2.reloadData()
                        
                    }
                    
                    
                }
                
                
                
                
                
                
        }
        
    }
    func loadRateData()  {
        
       
        
        
        let userID=120
        
        let url = "http://live-artists.com/admin/api/show/user/notific/\(userID)"
        
        
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[userNotificationModel]()
                    
                    let json = JSON(value)
                    print(json)
                    
                    if let dataArr = json["orders"].array
                    {
                        
                        for dataArr in dataArr {
                            let ar=userNotificationModel()
                            if let type=dataArr["type"].string,type == "2" {
                                if let providerId = dataArr ["provider_id"].string,
                                    let rateId = dataArr ["rate_id"].string,
                                    let text = dataArr ["text"].string
                                {
                                    
                                    ar.providerId=providerId
                                    ar.text=text
                                    ar.rateID=rateId
                                    
                                }
                            }
                            self.arrayRate.append(ar)
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                    
                    
                }
                
                
                
                
                
                
        }
        
    }
    
    

}
extension userNotificationVC:userNotificationCellDelegate{
    func didTapRate(rate: Double, provID: String) {
        addRate(rate: rate, provId: provID)
    }
    
    
}
