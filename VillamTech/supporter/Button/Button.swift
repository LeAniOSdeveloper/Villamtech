//
//  button.swift
//  VillamTech
//
//  Created by Ân Lê on 3/18/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation
import UIKit
extension UIButton{
    
    func customButtonBarImg(){
        self.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
    }
    func baseStyle(title : String , background : UIColor , borderWitdh : CGFloat ){
        self.layer.cornerRadius = 5
        self.setTitle(title, for: .normal)
        self.backgroundColor = background
        self.layer.borderWidth = borderWitdh
    }
    func customsearchBtn(background : UIColor , borderWitdh : CGFloat ){
        self.layer.cornerRadius = 5
        self.layer.borderWidth = borderWitdh
        self.layer.borderColor = #colorLiteral(red: 0.008692476898, green: 0.4969494343, blue: 0, alpha: 1)
       
    }
}
class UIButtonImage: UIButton{
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: 40, bottom: 5, right: bounds.width - 80)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: (imageView?.frame.width)! - 40 , bottom: 0, right: 0 )
        }
    }
}



