//
//  checkbox2.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 4/11/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit

class checkbox2: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var password: UITextField!
    var usertextfield: UITextField?
    
    
    @IBAction func LoginEnter(_ sender: UIButton) {
        
        guard let  Email = userName.text,!Email .isEmpty else {return}
        guard let password = password.text,!password .isEmpty else {return}
        
        
        APIService.providerlogin(username: Email
        , password: password ) { (error:Error?, success: Bool) in
            if success{
                //ss
            }else{
                //sss
                
                
            }
        }
    }

    

    @IBAction func checkbox2(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
    }    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userName.delegate = self
        self.password.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillchange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillchange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillchange(notification:)
            ), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
    }
    
    @objc func keyboardwillchange(notification:Notification){
        print("keyboardwillshow: \(notification.name.rawValue)")
        view.frame.origin.y = 0
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Forget2Pass(_ sender: Any) {
    
    let alertcontroller = UIAlertController(title: "Enter your email",
                                                message: nil,
                                                preferredStyle: .alert)
        alertcontroller.addTextField(configurationHandler: usertextfield)
        let Okaction = UIAlertAction(title: "ok", style: .default, handler: self.okhandler)
        let cancelAvtion = UIAlertAction(title:"cancel", style: .cancel, handler: nil)
        alertcontroller.addAction(Okaction)
        alertcontroller.addAction(cancelAvtion)
        self.present(alertcontroller, animated: true)
    }
    
    func usertextfield(textfield:UITextField){
        usertextfield = textfield
        usertextfield?.placeholder = "emxamble@icloud.com"
    }
    
    
    func okhandler(alert: UIAlertAction){
        
        
    }
    
    
    
    
    
}
        

    




