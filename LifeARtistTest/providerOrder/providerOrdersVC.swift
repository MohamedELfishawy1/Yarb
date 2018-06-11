//
//  providerOrdersVC.swift
//  LifeARtistTest
//
//  Created by mohamed on 5/2/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//


   
import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import BEMCheckBox
class providerOrdersVC: UIViewController {
        
        
        var array:[showData]=[]
        var array2:[showData]=[]
        @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var tableView2: UITableView!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            loadPasteData()
            loadfutureeData()
        }
        
        
        func loadPasteData()  {
         
            
                
                //let url = URLs.oldOrder
                
                
                let providerID=6
                
                let url = "http://live-artists.com/admin/api/show/orderprovider/\(providerID)"
                
                
                
                
                Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
                    .responseJSON { response in
                        
                        switch response.result
                        {
                        case .failure(let error):
                            
                            print(error)
                            
                        case .success(let value):
                            self.array=[showData]()
                            
                            let json = JSON(value)
                            print(json)
                            
                            if let dataArr = json["orders"].array
                            {
                                
                                for dataArr in dataArr {
                                    let ar=showData()
                                    
                                    
                                    
                                    if let oldDate = dataArr["old_date"].string ,oldDate == "0"{
                                        
                                        if let name = dataArr ["user"]["firstName"].string,
                                            let total = dataArr ["total"].string,
                                            let address = dataArr["date"].string,
                                            let orderID = dataArr["id"].int,
                                            let phone = dataArr["user"]["phone"].string,
                                            let date = dataArr ["date"].string,
                                             let pID=dataArr["provider_id"].string
                                        {
                                            
                                            ar.name=name
                                            ar.providerId=pID
                                            ar.total=total
                                            // ar.totalDetails=totalDetails
                                            ar.date=date
                                            ar.address=address
                                            ar.phone=phone
                                            ar.orderId=orderID
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
            
            
            let providerID=6
            
            let url = "http://live-artists.com/admin/api/show/orderprovider/\(providerID)"
            
            
            
            
            Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
                .responseJSON { response in
                    
                    switch response.result
                    {
                    case .failure(let error):
                        
                        print(error)
                        
                    case .success(let value):
                        self.array2=[showData]()
                        
                        let json = JSON(value)
                        print(json)
                        
                        if let dataArr = json["orders"].array
                        {
                            
                            for dataArr in dataArr {
                                let ar=showData()
                                
                                
                                
                                if let oldDate = dataArr["old_date"].string ,oldDate == "2"
                                {
                                    if let name = dataArr ["user"]["firstName"].string,
                                        let total = dataArr ["total"].string,
                                        let address = dataArr["date"].string,
                                        let orderID = dataArr["id"].int,
                                        let phone = dataArr["user"]["phone"].string,
                                        let date = dataArr ["date"].string,
                                        let pID=dataArr["provider_id"].string
                                        
                                    {
                                        ar.name=name
                                        ar.providerId=pID
                                        ar.total=total
                                        // ar.totalDetails=totalDetails
                                        ar.date=date
                                        ar.address=address
                                        ar.phone=phone
                                        ar.orderId=orderID
                                    }
                                }
                                self.array2.append(ar)
                            }
                            
                            self.tableView2.reloadData()
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                    
                    
            }
            
            
        }
   
    
        
    }

    // MARK: - TableView
    
extension providerOrdersVC:UITableViewDataSource,UITableViewDelegate{
        

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    
    
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if(tableView == self.tableView){
                
                //   return arrayRate.count
                
                return array.count
                
            }
            else{
                return array2.count
                
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "providerOrdersCell", for: indexPath) as! providerOrdersCell
            if tableView == self.tableView {
                cell.date.text=array[indexPath.row].date
                cell.name.text=array[indexPath.row].name
                cell.total.text=array[indexPath.row].total
                cell.orderID.text=String(describing: array[indexPath.row].orderId)
                 cell.delegate = self
            }
            if tableView == self.tableView2 {
                cell.date.text=array2[indexPath.row].date
                cell.name.text=array2[indexPath.row].name
                cell.total.text=array2[indexPath.row].total
                cell.orderID.text=String(describing: array2[indexPath.row].orderId)
                
                 cell.delegate = self
            }
            
            
            return cell
        }
    
    
        
    }
extension providerOrdersVC:providerOrdersCellDelegate {
    func didTapMore(orderID: Int) {
        print("total \(orderID)")
        Shared.shared.orderID = orderID
        
       performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    
    
    
    
   
    
    
    
}



