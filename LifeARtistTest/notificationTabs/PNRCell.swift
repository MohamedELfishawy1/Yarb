//
//  PNRCell.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/30/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Cosmos
class PNRCell: UITableViewCell {

    
    @IBOutlet var cosmosView: CosmosView!
    @IBOutlet weak var Title: UILabel!
 
    func update(_ rating: Double) {
        cosmosView.rating = rating
        Title.text=String(rating)
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
