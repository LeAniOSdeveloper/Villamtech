//
//  TextField.swift
//  VillamTech
//
//  Created by Ân Lê on 3/18/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
    func baseStyle(placeholder :  String ){
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.placeholder = placeholder
    }
    func addTitleInBorder(name : String ){
        
    }
}
