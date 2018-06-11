//
//  UNR.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/25/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Cosmos



protocol userNotificationCellDelegate {
    func didTapRate(rate:Double,provID: String)
   
}
class UNR: UITableViewCell {

    @IBOutlet var cosmosView: CosmosView!
    @IBOutlet weak var textt: UILabel!
    @IBOutlet weak var proID: UILabel!
    
    var delegate:userNotificationCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
    
    
    func update(_ rating: Double) {
        
        
        
        delegate?.didTapRate(rate: rating,provID: proID.text!)
       // cosmosView.rating = rating
       // id.text=String(rating)
        
    }

}
