//
//  category.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 4/4/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import Foundation
struct Category {
    private(set) public var title: String
    private(set) public var imageName: String
    
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}
