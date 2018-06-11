//
//  userOrderVC.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/22/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import BEMCheckBox
class userOrderVC: UIViewController {

    
    var array:[userOrderModel]=[]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPasteData()
        loadfutureeData()
    }
    
    
    func loadPasteData()  {
        
    
        
        
        
        // let userID=UserDefaults.standard.string(forKey: "userId")
        
        let userId=1
        let url="http://live-artists.com/admin/api/show/order/\(userId)"
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[userOrderModel]()
                    
                    let json = JSON(value)
                    print(json)
                    
                    if let dataArr = json["order"].array
                    {
                        
                        for dataArr in dataArr {
                            let ar=userOrderModel()
                            
                            
                            
                            if let oldDate = dataArr["old_date"].string ,oldDate == "0"
                            {
                                
                                
                                if let name = dataArr ["provider"]["username"].string,
                                    let total = dataArr ["total"].string,
                                    
                                    // let service = dataArr["service"].array,
                                    
                                    let date = dataArr ["date"].string
                                    
                                {
                                    
                                    ar.providerName=name
                                    //ar.nameDetails=name
                                    ar.total=total
                                    // ar.totalDetails=totalDetails
                                    ar.date=date
                                 
                                    //  ar.service=service
                                }
                                
                                
                                
                                
                            }
                            
                            
                            
                            
                            
                            self.array.append(ar)
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                    
                    
                }
                
                
                
                
                
                
        }
        
    }
  
    //
    
    
    func loadfutureeData()  {
        
       // let url = URLs.oldOrder
        
      let userId=1
      let url="http://live-artists.com/admin/api/show/order/\(userId)"
        
        
        Alamofire.request(url, method: .get,  encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[userOrderModel]()
                    
                    let json = JSON(value)
                    print(json)
                    
                    if let dataArr = json["order"].array
                    {
                        
                        for dataArr in dataArr {
                            let ar=userOrderModel()
                            
                            
                            
                            if let oldDate = dataArr["old_date"].string ,oldDate == "2"
                            {
                                if let name = dataArr ["provider"]["username"].string,
                                    let total = dataArr ["total"].string,
                                    let date = dataArr ["date"].string
                                    
                                {
                                    ar.providerName=name
                                    //ar.nameDetails=name
                                    ar.total=total
                                    // ar.totalDetails=totalDetails
                                    ar.date=date
                                    
                                }
                            }
                            self.array.append(ar)
                        }
                        
                        self.tableView2.reloadData()
                        
                    }
                        
                     
                    
                    
                }
                
                
                
                
                
                
        }
        
    }

}

// MARK: - TableView

extension userOrderVC:UITableViewDataSource,UITableViewDelegate,BEMCheckBoxDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userOrderCell", for: indexPath) as! userOrderCell
         if tableView == self.tableView {
        cell.date.text=array[indexPath.row].date
        cell.providerName.text=array[indexPath.row].providerName
        cell.total.text=array[indexPath.row].total
        }
         if tableView == self.tableView2 {
            cell.date.text=array[indexPath.row].date
            cell.providerName.text=array[indexPath.row].providerName
            cell.total.text=array[indexPath.row].total
            
            
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
  
}

}
