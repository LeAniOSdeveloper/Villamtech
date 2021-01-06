//
//  UIViewControllerExtend.swift
//  VillamTech
//
//  Created by Ân Lê on 5/31/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func hideKeyboard(){
        let tapDismisskeyboard = UITapGestureRecognizer(target: self, action: #selector(DismissKeyBoard))
        tapDismisskeyboard.cancelsTouchesInView = false
               view.addGestureRecognizer(tapDismisskeyboard)
    }
    @objc func DismissKeyBoard(){
        view.endEditing(true )
    }
}
