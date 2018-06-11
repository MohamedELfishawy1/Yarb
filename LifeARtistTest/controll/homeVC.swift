//
//  homeVC.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/12/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class homeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
   
    
    
   
    // array of label
    //  var titlee:[String]=[]
    var array:[homeModel]=[]
    var v:homeModel?
    
    
    @IBOutlet var coll: UICollectionView!
    
    
    @IBOutlet var SafeArea: NSLayoutConstraint!
    
    var issidehidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            self.loadData()
            DispatchQueue.main.async {
                self.coll.reloadData()
            
        
       
            }
        }
        
        
        view.backgroundColor = .white
        coll.backgroundColor = .clear
         SafeArea.constant = 600
    }
        
    @IBAction func Buttonside(_ sender: UIButton) {
    
    
        if issidehidden{
            SafeArea.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                
            })
        }else{
            SafeArea.constant = 600
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
        issidehidden = !issidehidden
        
        
    
    

    }
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! InternetConnection
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
        }
    }
    

    
    
  
    
    
    func loadData()  {
        
  
        
        
        let url = "http://live-artists.com/admin/api/get/adv"
        
        
        
        
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[homeModel]()
                    
                    let json = JSON(value)
                    // print(json)
                    
                    if let dataArr = json["images"].array
                    {
                        
                        
                        
                        for dataArr in dataArr {
                            let ar=homeModel()
                            if
                                let icon = dataArr ["url"].string
                                
                            {
                                
                                ar.icon=confic.imagePath+icon
                            }
                            
                            
                            
                            
                            self.array.append(ar)
                        }
                        
                        self.coll.reloadData()
                        
                    }
                    
                    
                }
                
                
                
                
                
                
                
                
        }
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // MyCollectionViewCell
        
        let cell:MyCollectionViewCell=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        //  cell.title.text=tasks[indexPath.row]
        
        
        
        // let resource=ImageResource(downloadURL: URL(string: array[indexPath.row].icon)!, cacheKey: array[indexPath.row].icon)
        // cell.icon.kf.setImage(with: resource)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        //let vc=UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VC2") as! VC2
        //  vc.firstCategoryId = array[indexPath.row].title
        //  self.present(vc, animated: true, completion: nil)
        
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

