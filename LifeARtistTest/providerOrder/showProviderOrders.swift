//
//  showProviderOrders.swift
//  LifeARtistTest
//
//  Created by mohamed on 5/2/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class showProviderOrders: UIViewController {

  
    
    
    @IBOutlet weak var services: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loadData()

    }
    func loadData()  {
        
        
        let providerID=6
        
        let url = "http://live-artists.com/admin/api/show/orderprovider/\(providerID)"
        
        
        let cn : Int = Shared.shared.orderID

        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                 
                    
                    let json = JSON(value)
                    print(json)
                    
                    if let dataArr = json["orders"].array
                    {
                        
                        for dataArr in dataArr {
                            let ar=showData()
                            
                            
                            
                            if let orderId = dataArr["id"].int ,  orderId==cn
                            {
                                if let name = dataArr ["user"]["firstName"].string,
                                    let total = dataArr ["total"].string,
                                    let address = dataArr["date"].string,
                                    let service=dataArr["services"].string,
                                    let phone = dataArr["user"]["phone"].string
                                   
                                    
                                    
                                {
                                    
                                    
                                   
                                    
                                    
                                    
                                    
                                    self.name.text=name
                                    self.total.text=total
                                    self.address.text=address
                                    self.phone.text=phone
                                    self.services.text=service
                                    
                                }
                            }
                           
                        }
                        
                      
                        
                    }
                    
                    
                }
                
                
                
                
                
                
        }
        
        
    }

    

   

}
