//
//  Label.swift
//  VillamTech
//
//  Created by Ân Lê on 3/18/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func addBorder(edge : UIRectEdge , color : UIColor , thickness : CGFloat){
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
                        border.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: thickness)
        case UIRectEdge.bottom :
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)

        case UIRectEdge.left :
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)

        case UIRectEdge.right :
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)

        
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }
    func clearBorder(){
        self.sublayers = nil
        
    }
//    func addBorderForLabel(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
    
}
extension UILabel {

}
