//
//  makeOrderCell.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/21/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import BEMCheckBox
class makeOrderCell: UITableViewCell,BEMCheckBoxDelegate  {
    @IBOutlet weak var service: UILabel!
    @IBOutlet weak var prize: UILabel!
    @IBOutlet weak var id: UILabel!
   
    
    var myTableViewController:makeOrderVC?
    var delegate:makeorderCellDelegate?
     var videoItem: makeOrderModel!
    
    
    
    func setVideo(video: makeOrderModel) {
        videoItem = video
        // Title.text = video.service
    }
    
    
    
    
    
    @IBOutlet weak var Check: BEMCheckBox!
    
    
    let picker = UIDatePicker()
    
    func didTap(_ checkBox: BEMCheckBox){
        if checkBox.tag == 0{
            delegate?.didTapCheck(price: prize.text!,providerId:id.text!)
        }
       
    }
    
    
    
    
    
    
//
//    @IBAction func acceptButton(_ sender: Any) {
//        delegate?.didTapCheck(price: prize.text!)
//
//
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Check.delegate=self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
protocol makeorderCellDelegate {
    func didTapCheck(price: String,providerId:String)
    
}

