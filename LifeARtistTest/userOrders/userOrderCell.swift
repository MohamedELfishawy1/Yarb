//
//  userOrderCell.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/22/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit

class userOrderCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var providerName: UILabel!
    @IBOutlet weak var total: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
