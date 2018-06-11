//
//  collectionview.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 4/7/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit

class collectionview: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    var songsList = [(title: "service", artist:"prices", artwork:"7")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! categorycell
        
        cell.service.text = songsList[indexPath.row].title
        
        cell.price.text = songsList[indexPath.row].artist
        
        let imgName = songsList[indexPath.row].artwork
        
        cell.profileimage.image = UIImage(named: imgName)
        
        
        
        return cell
    }

  

}
