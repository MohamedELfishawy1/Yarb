//
//  myservicecell.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 5/11/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit

class myservicecell: UITableViewCell {

    @IBOutlet var Name: UILabel!
    @IBOutlet var kind: UILabel!
    @IBOutlet var price: UILabel!
    
    @IBOutlet var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
