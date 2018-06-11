//
//  FilterResultVC.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/20/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import BEMCheckBox
class FilterResultVC: UIViewController,BEMCheckBoxDelegate {

     var sliderValue : Int=0
    
    var choose="select"
    var group:BEMCheckBoxGroup!
    @IBOutlet weak var highPrize: BEMCheckBox!
    @IBOutlet weak var lowPrize: BEMCheckBox!
    
    @IBOutlet weak var fromTF: UITextField!
    
    @IBOutlet weak var toTF: UITextField!
    
    func didTap(_ checkBox: BEMCheckBox){
        if checkBox.tag == 0{
            print("high")
            choose="high"
        }
        if checkBox.tag == 1{
            print("low")
            choose="low"
        }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //checkBox
        highPrize.delegate=self
        lowPrize.delegate=self
        group = BEMCheckBoxGroup(checkBoxes: [highPrize, lowPrize])
    }
    
    @IBAction func sliderChange(_ sender: UISlider) {
        
        sliderValue=Int(sender.value)
        print(sliderValue)
        
        
    }
}
