//
//  profileProvider.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/24/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire
import SwiftyJSON
import Kingfisher
class profileProvider: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
 
    @IBOutlet weak var providerName: UILabel!
    @IBOutlet weak var rateV: CosmosView!
   @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var collection2: UICollectionView!
    @IBOutlet weak var briefTV: UITextView!
    @IBAction func makeOrderButton(_ sender: Any) {
    }
    //photos
    @IBOutlet weak var collection: UICollectionView!
    var array:[providerModel]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // loadimageData()
        loadUserInfo()
        
    }
        
        
        func loadimageData()  {
            
            let userID=23
            
            let url="http://live-artists.com/admin/api/show/images/\(userID)"
            //let url = URLs.oldOrder
            
            
            
            
            Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
                .responseJSON { response in
                    
                    switch response.result
                    {
                    case .failure(let error):
                        
                        print(error)
                        
                    case .success(let value):
                        self.array=[providerModel]()
                        
                        let json = JSON(value)
                        // print(json)
                        
                        if let dataArr = json["images"]["data"].array
                        {
                            
                            
                            
                            for dataArr in dataArr {
                                let ar=providerModel()
                                if
                                    let icon = dataArr ["url"].string
                                    
                                {
                                    //                                ar.id=id
                                    ar.icon=icon
                                    //                                ar.icon=icon
                                }
                                
                                
                                
                                
                                self.array.append(ar)
                            }
                            
                            self.collection.reloadData()
                            
                        }
                        
                        
                    }
            }
                    
                    
                    
                    
                    
                    
                    
                    
            }
            
    func loadUserInfo()  {
        
       // let url = URLs.oldOrder
        let userID=23
        let url="http://live-artists.com/admin/api/show/provider/\(userID)"
        
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[providerModel]()
                    
                    let json = JSON(value)
                    // print(json)
                    
                    if let dataArr = json["provider"].array
                    {
                        
                        
                        
                        for dataArr in dataArr {
                          
                            if let brief = dataArr ["about"].string,
                                let name = dataArr ["fullName"].string,
                                let icon = dataArr ["image"].string,
                                let rate = dataArr ["rate"].string
                            {
                                self.briefTV.text=brief
                                self.providerName.text=name
                               self.rateV.rating = Double(rate)!
                                let resource=ImageResource(downloadURL: URL(string: icon)!, cacheKey: icon)
                                self.image.kf.setImage(with: resource)
                                
                            }
                            
                            
                            
                            
                        
                        }
                        
                     
                        
                    }
//                    if let RATE=json["rate"].string{
//                        print(RATE)
//                    self.rateV.rating = Double(RATE)!
         //           }
                    
                }
        }
    }
        
    

    func loadVideoData()  {
        
        
        
        
        let url = "http://live-artists.com/admin/api/show/videos/52"
        
        
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[providerModel]()
                    
                    let json = JSON(value)
                    // print(json)
                    
                    
                    
                    
                    if let dataArr = json["videos"]["data"].array
                    {
                        
                        
                        
                        for dataArr in dataArr {
                            let ar=providerModel()
                            if let video = dataArr ["url"].string
                                
                            {
                                //                                ar.id=id
                                ar.url=video
                                //                                ar.icon=icon
                            }
                            
                            
                            
                            
                            self.array.append(ar)
                        }
                        
                        self.collection2.reloadData()
                        
                    }//
                    
                    
                }
        }
        
        
        
        
        
        
        
        
    }
        
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return array.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "providerCell", for: indexPath) as! providerCell
             if collectionView == self.collection {
                    let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "providerCell", for: indexPath) as! providerCell
            let resource=ImageResource(downloadURL: URL(string: array[indexPath.row].icon)!, cacheKey: array[indexPath.row].icon)
            cell.profileimage.kf.setImage(with: resource)
                
                return cell
            }
             if collectionView == self.collection2 {
                let cell2=collectionView.dequeueReusableCell(withReuseIdentifier: "providerVideoCell", for: indexPath) as! proiderVideoCell
                
                let s=URL(string: array[indexPath.row].url)
                let url=URLRequest(url: s!)
                cell2.webView.loadRequest(url)
            return cell2
            
            }
            
            
            
         return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("image number \(indexPath.row)")
           // v=array[indexPath.row]
            //
            //        print("image number \(array[indexPath.row].id)")
            //        performSegue(withIdentifier: "go", sender: array[indexPath.row])
            
            
            //let vc=UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VC2") as! VC2
            //  vc.firstCategoryId = array[indexPath.row].title
            //  self.present(vc, animated: true, completion: nil)
            
            
            
            
            
        }
        
    }


