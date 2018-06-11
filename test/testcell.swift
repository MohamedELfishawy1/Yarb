//
//  testcell.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 5/13/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit

class testcell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var Name: UILabel!
    @IBOutlet var kind: UILabel!
    @IBOutlet var prise: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
