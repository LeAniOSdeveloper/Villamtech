//
//  DetailTableViewCell.swift
//  VillamTech
//
//  Created by Ân Lê on 5/25/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var viewCont: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCont.layer.cornerRadius = 5
        viewCont.layer.borderColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
        viewCont.layer.borderWidth = 1
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
