//
//  sidemenu3.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 4/1/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit

class sidemenu3: UIViewController {

    @IBOutlet weak var SafeArea3: NSLayoutConstraint!
    
    var issidehidden3 = true
    override func viewDidLoad() {
        super.viewDidLoad()
        SafeArea3.constant = 600

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button3(_ sender: UIButton) {
        if issidehidden3{
            SafeArea3.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()            })
        }else{
            SafeArea3.constant = 600
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        
    }
    issidehidden3 = !issidehidden3
    
    }
    @IBAction func button2(_ sender: UIButton) {
        if issidehidden3{
            SafeArea3.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
       // }else{
          //  SafeArea3.constant = 600
            //UIView.animate(withDuration: 0.3, animations: {
              //  self.view.layoutIfNeeded()
            //})
        }
        issidehidden3 = !issidehidden3
    }
    

}
