//
//  APIService.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 4/11/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIService: NSObject {
    
    
    // MARK : user login
    class func userlogin(Number:String,password:String,completion: @escaping (_ error: Error?, _ success: Bool)->Void){
        let url =  "http://live-artists.com/admin/api/provider/login/2"
        let parameters = [
            
            "Number": Number,
            "password": password
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            . responseJSON { (response) in
                switch response.result
                {
                case.failure(let error):
                    completion(error, false)
                    print(error)
                    
                case.success(let Value):
                    let json = JSON(Value)
                    //    let api_token = json["user"]["api_token"].string
                    //   completion(nil, true)
                    
                    
                    
                    
                    //
                    if let dataArr = json["userLogin"]["data"].array
                    {
                        
                        
                        
                        for dataArr in dataArr {
                            
                            if let providerId = dataArr ["id"].int,
                                let firstName = dataArr ["firstName"].string,
                                let lastName = dataArr ["lastName"].string,
                                let fullName = dataArr ["fullName"].string,
                                let email = dataArr ["email"].string,
                                let phone = dataArr ["phone"].string,
                                let password = dataArr["password"].string
                            {
                                
                                let defult=UserDefaults.standard
                                defult.set(email, forKey: "email")
                                defult.set(phone, forKey: "phone")
                                defult.set(firstName, forKey: "firstName")
                                defult.set(lastName, forKey: "lastName")
                                defult.set(fullName, forKey: "fullName")
                                defult.set(password, forKey: "password")
                                defult.set(providerId, forKey: "id")
                                defult.synchronize()
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    completion(nil, true)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
        }
    }
    
    
    
    
    
    
    //
    
    
    
    // MARK : provider login
    class func providerlogin(username:String,password:String,completion: @escaping (_ error: Error?, _ success: Bool)->Void){
        let url =  "http://live-artists.com/admin/api/provider/login/1"
        let parameters = [
            
            "username": username,
            "password": password
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            . responseJSON { (response) in
                switch response.result
                {
                case.failure(let error):
                    completion(error, false)
                    print(error)
                    
                case.success(let Value):
                    let json = JSON(Value)
                    
                    if let dataArr = json["providerLogin"]["data"].array
                    {
                        
                        
                        
                        for dataArr in dataArr {
                            
                            
                            if let providerId = dataArr["id"].int,
                                let fullName = dataArr["fullName"].string,
                                let username = dataArr["username"].string,
                                let address = dataArr ["address"].string,
                                let email = dataArr["email"].string,
                                let phone = dataArr["phone"].string,
                                let tradeName = dataArr["tradeName"].string,
                                let about = dataArr ["about"].string,
                                let image = dataArr["image"].string,
                                let password = dataArr["password"].string
                                
                            {
                                
                                let defult=UserDefaults.standard
                                
                                defult.set(username, forKey: "username")
                                defult.set(tradeName, forKey: "tradeName")
                                defult.set(fullName, forKey: "fullName")
                                
                                defult.set(about, forKey: "about")
                                defult.set(address, forKey: "address")
                                defult.set(confic.imagePath+image, forKey: "image")
                                
                                defult.set(email, forKey: "email")
                                defult.set(phone, forKey: "phone")
                                defult.set(password, forKey: "password")
                                defult.set(providerId, forKey: "providerId")
                                defult.synchronize()
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    completion(nil, true)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
        }
    }
    
    
    // MARK :- Register user
    class func registerProvider(fullName:String,userName:String,email:String,password:String,Number:String,image:UIImage,about:String,address:String,lat:String,long:String,tradeName:String,completion: @escaping (_ error: Error?, _ success: Bool)->Void){
        let url = "http://live-artists.com/admin/api/add/provider/1"
        
        let prameters = [
            "image":image,
            "fullName":fullName,
            "username":userName,
            "email":email,
            "password":password,
            "address":address,
            "tradeName":tradeName,
            "long":long,
            "lat":lat,
            "about":about
            
            
            ] as [String : Any]
        Alamofire.request(url, method: .post, parameters: prameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            . responseJSON { (response) in
                switch response.result
                {
                case.failure(let error):
                    completion(error, false)
                    print(error)
                    
                case.success(let Value):
                    let json = JSON(Value)
                    
                    
                    
                    
                    
                    
                    
                    if let providerId = json["providerResponse"]["id"].int,
                        let fullName = json["providerResponse"]["fullName"].string,
                        let username = json["providerResponse"]["username"].string,
                        let address = json["providerResponse"] ["address"].string,
                        let email = json["providerResponse"] ["email"].string,
                        let phone = json["providerResponse"] ["phone"].string,
                        let tradeName = json["providerResponse"] ["tradeName"].string,
                        let about = json["providerResponse"] ["about"].string,
                        let image = json["providerResponse"] ["image"].string,
                        let password = json["providerResponse"]["password"].string
                        
                    {
                        
                        let defult=UserDefaults.standard
                        
                        defult.set(username, forKey: "username")
                        defult.set(tradeName, forKey: "tradeName")
                        defult.set(fullName, forKey: "fullName")
                        
                        defult.set(about, forKey: "about")
                        defult.set(address, forKey: "address")
                        defult.set(image, forKey: "image")
                        
                        defult.set(email, forKey: "email")
                        defult.set(phone, forKey: "phone")
                        defult.set(password, forKey: "password")
                        defult.set(providerId, forKey: "providerId")
                        defult.synchronize()
                        
                    }
                    
                    
                    
                    
                    
                    completion(nil, true)
                    
                    
                    
                    
                }
                
        }
    }
    
    
    
    
    // MARK :- Register user
    class func register(firstname:String,lastname:String,email:String,password:String,Number:String,completion: @escaping (_ error: Error?, _ success: Bool)->Void){
        let url = "http://live-artists.com/admin/api/add/provider/1"
        
        let prameters = [
            
            "firstname":firstname,
            "lastname":lastname,
            "email":email,
            "password":password,
            "Number":Number
            
            
        ]
        Alamofire.request(url, method: .post, parameters: prameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            . responseJSON { (response) in
                switch response.result
                {
                case.failure(let error):
                    completion(error, false)
                    print(error)
                    
                case.success(let Value):
                    let json = JSON(Value)
                    let api_token = json["user"]["api_token"].string
                    completion(nil, true)
                    
                    
                    
                    
                }
                
        }
    }
    
    
}

