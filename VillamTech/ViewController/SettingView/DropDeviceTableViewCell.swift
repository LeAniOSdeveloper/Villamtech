//
//  DropDeviceTableViewCell.swift
//  VillamTech
//
//  Created by Ân Lê on 5/14/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit
import iOSDropDown
class DropDeviceTableViewCell: UITableViewCell, UITextFieldDelegate {
    var gardensIds : [String]?
    var gardenName:[String] = [] {
        didSet{
            
        }
    }
    @IBOutlet weak var gardenTf: DropDown!
    
    @IBOutlet weak var deviceTf: DropDown!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        guard let gardenName = gardenName else {
//            return
//        }
       
        
//        gardenTf.hideList()
        gardenTf.checkMarkEnabled = false
        gardenTf.optionArray = gardenName
//        gardenTf.optionArray = gardenName
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setup(){
        deleteBtn.layer.cornerRadius = 5
        deleteBtn.setTitle("Xoá", for: .normal)
    }
}
