//
//  myserviceViewController.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 5/11/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit

class myserviceViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var textTF: UITextField!
    @IBOutlet var textTF2: UITextField!
    @IBOutlet var TableView: UITableView!
    @IBOutlet var tableview2: UITableView!
    @IBOutlet var popAlert: UIVisualEffectView!
    var items = [String]()
   // var array:[sModel]=[]
    

    
    let aniDuration = 0.7
    
    @IBAction func DoneButton(_ sender: Any) {
        
        if textTF.text?.isEmpty == true {
           
        } else {
            items.append(textTF.text!)
            
            
            UserDefaults.standard.set(items, forKey: "SavedData")
            TableView.reloadData()
            
            //Show the pop-up with animation
            animatePopup(alpha: 0.0)
            
            //Re-set the text field for next use
            textTF.text = ""
            
        }
        
        if textTF2.text?.isEmpty == true {
           
        } else {
            items.append(textTF2.text!)
            
            
            UserDefaults.standard.set(items, forKey: "SavedData")
            TableView.reloadData()
            
            //Show the pop-up with animation
            animatePopup(alpha: 0.0)
            
            //Re-set the text field for next use
            textTF2.text = ""
            
        }
        
    }
    
    @IBAction func Cancel(_ sender: Any) {
        animatePopup(alpha: 0.0)
        textTF.text = ""
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        popAlert.alpha = 1
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        if let data = UserDefaults.standard.value(forKey: "SavedData") as? [String] {
            
            //Yes, there is saved data and we are loading it to our array and then we reload the tableview to read again from the array after we updated its data
            items = data
        }

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myservicecell", for: indexPath)as! myservicecell
        
        
        cell.Name.text = items[indexPath.row]
        cell.price.text = items[indexPath.row]
        cell.kind.text = items[indexPath.row]
        
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //Swipe to delete
        if editingStyle == .delete {
            //Remove that task from array
            self.items.remove(at: indexPath.row)
            UserDefaults.standard.set(items, forKey: "SavedData")
            UserDefaults.standard.synchronize()
            TableView.reloadData()
        }
    }



func animatePopup(alpha: CGFloat) {
    UIView.animate(withDuration: aniDuration) {
        self.popAlert.alpha = alpha
    }
}

}
