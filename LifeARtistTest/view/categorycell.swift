//
//  categorycell.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 4/3/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit

class categorycell: UITableViewCell {
    
    @IBOutlet weak var sidemenu: UIImageView!
    
    
    @IBOutlet weak var profileimage: UIImageView!
    
    @IBOutlet weak var service: UILabel!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
