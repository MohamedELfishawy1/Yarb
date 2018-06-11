//
//  sidemenu.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 3/23/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit

class sidemenu: UIViewController {
    
    @IBOutlet weak var safeArea1: NSLayoutConstraint!
    var issidemenuhidden = true
    

    override func viewDidLoad() {
        super.viewDidLoad()

        safeArea1.constant = 600
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sidemenu1(_ sender: UIButton) {
        if issidemenuhidden{
            safeArea1.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                
            })
            
        }else{
            safeArea1.constant = 600
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                
            })
        }
        issidemenuhidden = !issidemenuhidden
    }    }
    


