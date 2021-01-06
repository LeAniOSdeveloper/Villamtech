//
//  OptionTableViewCell.swift
//  VillamTech
//
//  Created by Ân Lê on 4/20/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit

class OptionTableViewCell: UITableViewCell {
    var device : Device?

    @IBOutlet weak var doamLb: UILabel!
    @IBOutlet weak var phLb: UILabel!
    @IBOutlet weak var nhietdoLb: UILabel!{
        didSet{
//            nhietdoLb.text = "\(device?.indices?[0].value ?? 0)"
        }
    }
    @IBOutlet weak var wifiLabel: UILabel!
    @IBOutlet weak var namePlant: UILabel!
    @IBOutlet weak var viewBase: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViewBase(borderWidth: 1, radiusCorner: 10, borderColor: #colorLiteral(red: 0.006415538955, green: 0.3875015974, blue: 0.2966505587, alpha: 1))
        namePlant.backgroundColor = #colorLiteral(red: 0.006415538955, green: 0.3875015974, blue: 0.2966505587, alpha: 1)
        namePlant.textColor  = .white
        namePlant.roundCorners(corners: [.topLeft], radius: 10)
        wifiLabel.layer.borderWidth = 1
        wifiLabel.clipsToBounds = true
        wifiLabel.layer.cornerRadius = 10
        wifiLabel.layer.maskedCorners = [.layerMaxXMinYCorner]
        wifiLabel.layer.borderColor = #colorLiteral(red: 0.006415538955, green: 0.3875015974, blue: 0.2966505587, alpha: 1)
        nhietdoLb.text = "\(device?.indices[0].value ?? 0)"
        
    }
    func setupViewBase(borderWidth : CGFloat , radiusCorner : CGFloat , borderColor : CGColor){
        viewBase.layer.borderWidth = borderWidth
        viewBase.layer.cornerRadius = radiusCorner
        viewBase.layer.borderColor = borderColor
        
        //Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { (_) in
        
        //}
        
    }
    
    func setData(device : Device) {
        //            cell.device = sensorDevices[indexPath.row]
        //            cell.nhietdoLb.text = "\(sensorDevices[indexPath.row].indices![0].value ?? 0)"
        //            cell.phLb.text = "\(sensorDevices[indexPath.row].indices![2].value ?? 0)"
        //            cell.doamLb.text = "\(sensorDevices[indexPath.row].indices![3].value ?? 0)"
        //            cell.namePlant.text = "\(sensorDevices[indexPath.row])"
        var indices = device.indices
//        guard  let indices = device.indices else {
//            return
//        }
        for x in indices {
            if x.type == "Temp" {
                nhietdoLb.text = "\(String(describing: x.value!))"
            }
            if x.type == "Ph"{
                phLb.text = "\(String(describing: x.value! ))"
            }
            if x.type == "Tds"{
                doamLb.text = "\(String(describing: x.value!))"
            }
        }
//        nhietdoLb.text = "\(indices[0].value ?? 0 )"
//        phLb.text = "\(indices[2].value ?? 0 )"
//        doamLb.text = "\(indices[3].value ?? 0 )"
        namePlant.text = device.planName
        if device.isDiconnected {
            wifiLabel.text = "Online"
        }
        else{
            wifiLabel.text = "False"
        }
        

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
