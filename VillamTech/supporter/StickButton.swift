//
//  StickButton.swift
//  VillamTech
//
//  Created by Ân Lê on 4/1/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation
import UIKit
class StickButton : UIButton{
    let checked = UIImage(named: "icons8-checked-checkbox-50")
    let unchecked = UIImage(named: "icons8-unchecked-checkbox-50")
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checked, for: UIControl.State.normal)
            } else {
                self.setImage(unchecked, for: UIControl.State.normal)
            }
        }
    }
   override func awakeFromNib() {
    self.tintColor = .red
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    @objc func buttonClicked(sender: UIButton) {
           if sender == self {
               isChecked = !isChecked
           }
       }
}
