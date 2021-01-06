//
//  ViewController.swift
//  VillamTech
//
//  Created by Ân Lê on 4/9/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    func styleCell(borderWidth : Float ){
        
    }
    
}
extension UIView{
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
       let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
       let mask = CAShapeLayer()
       mask.path = path.cgPath
       self.layer.mask = mask
    }
}


