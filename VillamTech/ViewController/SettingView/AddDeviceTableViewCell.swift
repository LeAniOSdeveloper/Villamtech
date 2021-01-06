//
//  AddDeviceTableViewCell.swift
//  VillamTech
//
//  Created by Ân Lê on 5/31/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit
import iOSDropDown
protocol PushDelegate:class {
    func pushView()
}
class AddDeviceTableViewCell: UITableViewCell {
    var dataGarden : [Garden]?
    weak var pushviewDelegate : PushDelegate?
    var sensorRecordsAPI : SensorRecordsAPI!
    //    var tempIdGarden : [String]?
    weak var alertdelegate : AlertDelegate?
    var idGarden : String?
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var treeTf: UITextField!
    @IBOutlet weak var scanID: UIButton!
    @IBOutlet weak var idDevice: UITextField!
    @IBOutlet weak var chooseGarden: DropDown!
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
//        chooseGarden.ge
        
        var tempName : [String] = []
        guard let dataGarden = dataGarden else {
            return
        }
        for x in dataGarden{
            tempName.append(x.name)
        }
        chooseGarden.optionArray = tempName
        
        // Initialization code
    }
    func setup(){
        addBtn.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        addBtn.layer.cornerRadius = 5
        addBtn.layer.borderWidth = 2
        addBtn.tintColor  = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
        //        addBtn.titleLabel?.text = "Thêm"
        
        scanID.setTitle("QUET MÃ", for: .normal)
        scanID.setImage(UIImage(named: "icons8-compact-camera-25"), for: .normal)
        scanID.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        scanID.layer.cornerRadius = 5
        scanID.layer.borderWidth = 2
        scanID.tintColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
        addBtn.setTitle("Thêm", for: .normal)
        //        addBtn.
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func addTreeBtn(_ sender: Any) {
        guard let idGarden = idGarden else {
            return
        }
        sensorRecordsAPI = SensorRecordsAPI(path: SENSORRECORD.sharing.post_AddUpdateDevice)
        let configs = [ConfigDevice(type: "Ph", min: 0.0, max: 7.0),ConfigDevice(type: "Temp", min: 10 , max: 40 ),ConfigDevice(type: "Tds", min: 0.5, max: 7.5)]
        guard let idDevice = idDevice.text else {
            return
        }
        if idDevice == ""{
            alertdelegate?.callAlert(nameofGarden: "Bạn chưa quét mã QR")
            //            return
        }
        else {
            guard let treeTf = treeTf.text else {
                return
            }
            if treeTf == ""{
                alertdelegate?.callAlert(nameofGarden: "Bạn chưa quét mã QR")
            }
            else {
                let device = DeviceRequest(gardenId: idGarden, deviceId: idDevice , planname: treeTf , config: configs )
                sensorRecordsAPI.addSensorRecord(device: device) { (data) in
                    if data.result == true {
                        self.alertdelegate?.callAlerSuccess(title: "Thành công", messager: "")
                    }
                }
            }
        }
        
        
    }
    @IBAction func scanID(_ sender: Any) {
        print("hello")
        pushviewDelegate?.pushView()
        //        let camraQR = MainStoryBoard.instantiateViewController(identifier: "QRScanViewController")
        //        if let navigation =
    }
}
