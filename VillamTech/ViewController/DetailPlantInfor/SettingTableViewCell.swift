//
//  SettingTableViewCell.swift
//  VillamTech
//
//  Created by Ân Lê on 5/25/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var imglogo: UIImageView!
    @IBOutlet weak var viewCon: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        settup()
        // Initialization code
    }
    func settup(){
        viewCon.layer.borderWidth  = 1
        viewCon.layer.borderColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
        viewCon.layer.cornerRadius = 5
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
