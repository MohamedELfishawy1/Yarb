//
//  ResultVCCell.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/20/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Cosmos
class ResultVCCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
   
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var prize: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var service: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
