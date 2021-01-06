//
//  User.swift
//  VillamTech
//
//  Created by Ân Lê on 4/3/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation
let standardUserDefaults = UserDefaults.standard
struct User {
    var email : String
    var password : String

    init(){
        email = "levohoangan@gmail.com"
        password = "123456"
    }
}

