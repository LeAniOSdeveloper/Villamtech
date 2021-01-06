//
//  TaoVuonRauTableViewCell.swift
//  VillamTech
//
//  Created by Ân Lê on 5/31/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit
protocol AlertDelegate: class {
    func callAlert(nameofGarden : String )
    func callAlerSuccess(title : String , messager : String )
}
class TaoVuonRauTableViewCell: UITableViewCell {
    var gardensAPI :  GardenAPI?
    weak var alertDelegate : AlertDelegate?
    var nameArrGarden : [String] = []
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var addressTf: UITextField!
    @IBOutlet weak var nameGarden: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        
        // Initialization code
    }
    func setup(){
        createBtn.layer.borderWidth = 2
        createBtn.layer.cornerRadius = 5
        createBtn.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        createBtn.tintColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
        
        createBtn.titleLabel?.text = "Tạo"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func createBtn(_ sender: Any) {
        let api = GARDENAPI()
        gardensAPI = GardenAPI(path: api.POST_ADDGARDEN)
        
        
        guard let nameGarden = nameGarden.text else {
            //            alertDelegate?.callAlert(nameofGarden:  "Bạn chưa nhập Tên Vườn " )
            return
        }
        if nameGarden == ""{
            alertDelegate?.callAlert(nameofGarden:  "Bạn chưa nhập Tên Vườn " )
            
        }
        else {
            for name in nameArrGarden {
                if nameGarden == name {
                    alertDelegate?.callAlert(nameofGarden:  "Tên Vườn đã tồn tại" )
                    
                    
                    
                }
            }
            guard  let addressTf = addressTf.text else {
                
                return
            }
            if addressTf == ""{
                alertDelegate?.callAlert(nameofGarden: "Bạn chưa nhập Địa Chỉ" )
                
            }
            else {
                gardensAPI?.addGarden(ID: "", nameGarden: nameGarden, idGarden: "", addressGarden: addressTf, completion: { (data) in
                    print(data)
                    self.alertDelegate?.callAlerSuccess(title: "Tạo vườn thành công", messager: ""  )
                    self.nameGarden.text = ""
                    self.addressTf.text=""
                    print(data.result)
                    if data.result != nil {
                        
                        
                    }
                }
                )
            }
            
        }
        
    }
    
}
