//
//  nowVC.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/14/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//


import UIKit
import XLPagerTabStrip
import Foundation
import FoldingCell
import Alamofire
import SwiftyJSON
import Kingfisher
class nowVC: UIViewController {
        
        var array:[showData]=[]
        @IBOutlet weak var tableView: UITableView!
     
        var firstCategory:String?
    
        
        
        let kCloseCellHeight: CGFloat = 179
        let kOpenCellHeight: CGFloat = 488
        let kRowsCount = 10
        var cellHeights: [CGFloat] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setup()
            
        }
        
    
        
        
        
        
        
        
        private func setup() {
            loadData()
            cellHeights = Array(repeating: kCloseCellHeight, count: kRowsCount)
            tableView.estimatedRowHeight = kCloseCellHeight
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "BG"))
        }
        
        
        func loadData()  {
            
            let url = URLs.nowOrder
            // let id=firstCategoryId?.id
            
            
            
            
            let idd=firstCategory
            print("idd = \(idd!)")
            let id=idd!
            
            //  let id="4"
            print("id = \(id)")
            
            let currentLocale = Locale.current.regionCode!
            let parameters = [
                
                //            "id": id!,
                "id": id,
                //"country": "EG" //currentLocale
                
            ]
            
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
                .responseJSON { response in
                    
                    switch response.result
                    {
                    case .failure(let error):
                        
                        print(error)
                        
                    case .success(let value):
                        self.array=[showData]()
                        
                        let json = JSON(value)
                        print(json)
                        
                        if let dataArr = json["second_category"].array
                        {
                            
                            for dataArr in dataArr {
                                let ar=showData()
                                if let service = dataArr ["lost_item_ID"].string,
                                    let name = dataArr["name"].string,
                                    let total = dataArr["email"].string,
                                    let phone = dataArr["mobile"].string,
                                    let date = dataArr ["lost_Date"].string,
                                    let address = dataArr ["losing_details"].string
                                {
                                    ar.address=address
                                    ar.service=service
                                    ar.nameDetails=name
                                    ar.date=date
                                    ar.name=name
                                    ar.phone=phone
                                    ar.total=total
                                    ar.totalDetails=total
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
    
    extension nowVC:UITableViewDataSource,UITableViewDelegate{
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return array.count
        }
        
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            guard case let cell as DemoCellTwo = cell else {
                return
            }
            
            
            
            cell.nameDetails.text=array[indexPath.row].nameDetails
            cell.address.text=array[indexPath.row].address
            cell.total.text=array[indexPath.row].total
            cell.totalDetails.text=array[indexPath.row].totalDetails
            cell.service.text=array[indexPath.row].service
            cell.date.text=array[indexPath.row].date
            cell.phone.text=array[indexPath.row].phone
            cell.name.text=array[indexPath.row].name
            
            
            
            
            cell.backgroundColor = .clear
            
            if cellHeights[indexPath.row] == kCloseCellHeight {
                cell.unfold(false, animated: false, completion: nil)
            } else {
                cell.unfold(true, animated: false, completion: nil)
            }
            
            cell.number = indexPath.row
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
            let durations: [TimeInterval] = [0.26, 0.2, 0.2]
            cell.durationsForExpandedState = durations
            cell.durationsForCollapsedState = durations
            return cell
        }
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return cellHeights[indexPath.row]
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
            
            if cell.isAnimating() {
                return
            }
            
            var duration = 0.0
            let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
            if cellIsCollapsed {
                cellHeights[indexPath.row] = kOpenCellHeight
                cell.unfold(true, animated: true, completion: nil)
                duration = 0.5
            } else {
                cellHeights[indexPath.row] = kCloseCellHeight
                cell.unfold(false, animated: true, completion: nil)
                duration = 0.8
            }
            
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                tableView.beginUpdates()
                tableView.endUpdates()
            }, completion: nil)
        }
    }
    
    extension nowVC:IndicatorInfoProvider{
        func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
            return IndicatorInfo(title: "Found")
        }
}

