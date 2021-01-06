//
//  ChinhSuaCell.swift
//  VillamTech
//
//  Created by Ân Lê on 5/15/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit
import iOSDropDown
protocol reloadWhenUpdateGarden :class{
    func reload(data : [Garden])
}
class ChinhSuaCell: UITableViewCell {
    weak var reloadUpdateGarden : reloadWhenUpdateGarden! = nil
    @IBOutlet weak var fixBtn: UIButton!
    @IBOutlet weak var addressTf: UITextField!
    @IBOutlet weak var nameGardenTf: UITextField!
    @IBOutlet weak var gardenTf: DropDown!
    var idGarden  : String?
    var idUser : String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    func setup(){
        
        fixBtn.tintColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
        fixBtn.layer.cornerRadius = 5
        fixBtn.layer.borderWidth = 2
        fixBtn.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    
    }
//    func infoGarden( )
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func updateGarden(_ sender: Any) {
        let gardenapi = GARDENAPI()
        let rq = GardenAPI(path: gardenapi.POST_ADDGARDEN)
        guard let idGarden = idGarden else {
            return 
        }
        print(idGarden)
        rq.addGarden(ID: idUser, nameGarden: nameGardenTf.text ?? "", idGarden: idGarden , addressGarden: addressTf.text ?? "") { (rp) in
            if rp.result == nil {
                var api = LinkAPI_http()
                var rq1 = GardenAPI(path: api.GET_GARDEN)
                rq1.getGarden { (gardens) in
                    self.reloadUpdateGarden.reload(data: gardens.result)
//                    gardens.result
                    self.gardenTf.placeholder = self.nameGardenTf.text ?? ""
                    self.gardenTf.layoutIfNeeded()
                    
                }
              
            }
        }
    }
    
}
