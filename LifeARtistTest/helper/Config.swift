//
//  Config.swift
//  LostOrFound
//
//  Created by mohamed on 3/11/18.
//  Copyright © 2018 mohamed. All rights reserved.
//

import Foundation

struct URLs {
    

    
    // search
    static let login = "http://lostorrfound.com/JSON/login.php?do=login"
    // search
    static let register = "http://lostorrfound.com/JSON/users.php?do=insert"
    
    // search
    static let forget = "http://lostorrfound.com/JSON/search.php?do=all"
    // MARK:- CATEGORY
    /// GET {Parent Category}
    static let nowOrder = "http://lostorrfound.com/JSON/second_category.php?do=SelectAll"
    
    // parent Category Arabic
     static let oldOrder = "http://lostorrfound.com/JSON/second_category_arabic.php?do=SelectAll"
    
    
    
    // second category
    static let secondCategory = "http://lostorrfound.com/JSON/third_category.php?do=SelectByid"
    
}

