//
//  PlantViewController.swift
//  VillamTech
//
//  Created by Ân Lê on 4/5/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit
import  NavigationDrawer
import iOSDropDown

class PlantViewController: UIViewController  {
    var indexNow : Int = 0
    let path = LinkAPI_http()
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var api : GardenAPI?
    var sensorData : SensorRecordsAPI?
    var urlSenSor = SENSORRECORD()
    var dataGardens : Gardens?{
        didSet{
            OptionTable.reloadData()
        }
    }
    var timerRequest : Timer?
    var garden : Garden?
    var sensorDevices :[Device]?{
        didSet{
            OptionTable.reloadData()
        }
    }
    
    weak var callMenuDelegate : HomeControllerDelegate?
    let interactor = Interactor()
    var arrOption :[String] = ["section1","section2","section3","section4"]
    @IBOutlet weak var OptionTable: UITableView!
    @IBOutlet weak var dropBoxTF: DropDown!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.isHidden = true
        self.navigationController?.navigationBar.topItem?.title = "Bảng Theo Dõi"
        GardenAPI.init(path: path.GET_GARDEN).getGarden { (garden ) in
            self.dataGardens = garden
        }
        reloadDataDropDown()
//        view.gestureRecognizers?.removeAll()
        timerRequest = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(runTimeCode), userInfo: nil, repeats: true)
        hideKeyboard()
    }
    @objc func runTimeCode() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (time) in
            if ( self.indexNow != 0){
                if let dataGardens = self.dataGardens{
                    self.sensorData = SensorRecordsAPI(path: self.urlSenSor.get_SENSORRECORD_GETVALUE(gardenID: dataGardens.result[self.indexNow].gardenId, deviceId: nil))
                    self.sensorData?.getSensorRecords() { (data) in
                        //                            print(data)
                        if let dataresult = data?.result {
                            
                            self.sensorDevices = dataresult
                            
                        }
                    }
                }
            }
            
        }
        print("hello babay")
    }
    func reloadDataDropDown(){
        var tempArrOption : [String] = []
        if let gardens = dataGardens {
            
            if gardens.result.isEmpty {
                print("nil")
            }
            else {
                
                garden = gardens.result[0]
            }
            
        }
        
        
        if let gardens = dataGardens?.result {
            for index in gardens{
                tempArrOption.append(index.name)
            }
            
        }
        dropBoxTF.optionArray = tempArrOption
        
        dropBoxTF.optionIds = [0,1,2,3]
        dropBoxTF.selectedRowColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
        
        addLable(title : "Chọn vườn rau")
        OptionTable.delegate = self
        OptionTable.dataSource = self
        dropBoxTF.didSelect { (selectedText, index, id) in
            self.indexNow = index
            //            guard let indexNow = self.indexNow else {
            //                return
            //            }
            DispatchQueue.main.async {
                self.indicator.startAnimating()
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (time) in
                    
                    if let dataGardens = self.dataGardens{
                        self.sensorData = SensorRecordsAPI(path: self.urlSenSor.get_SENSORRECORD_GETVALUE(gardenID: dataGardens.result[self.indexNow].gardenId, deviceId: nil))
                        self.sensorData?.getSensorRecords() { (data) in
                            //                            print(data)
                            if let dataresult = data?.result {
                                
                                self.sensorDevices = dataresult
                                
                            }
                        }
                        self.OptionTable.reloadData()
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                    }
                }
                
                
            }
        }
    }
    func loadDatadropdown(){
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GardenAPI.init(path: path.GET_GARDEN).getGarden { (garden ) in
            print(garden)
            
            var tempArrOption : [String] = []
            let gardens = garden.result
            
            for index in gardens{
                tempArrOption.append(index.name)
            }
            
            
            print(tempArrOption)
            self.dropBoxTF.optionArray = tempArrOption
            
            
        }
        
        
        // OptionTable.reloadData()
        // Hide the navigation bar on the this view controller
        //      self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func addLable(title:String){
        let lable = UILabel()
        
        lable.text = title
        lable.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lable.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lable.backgroundColor = .white
        lable.textColor = #colorLiteral(red: 0.008692476898, green: 0.4969494343, blue: 0, alpha: 1)
        
        lable.translatesAutoresizingMaskIntoConstraints = false
        self.view.bringSubviewToFront(lable)
        
        self.view.addSubview(lable)
        
        lable.leftAnchor.constraint(equalTo: dropBoxTF.leftAnchor, constant: 20).isActive = true
        lable.topAnchor.constraint(equalTo: dropBoxTF.topAnchor, constant: -10).isActive = true
        
    }
    func addimgbtn(path : String){
        
    }
    
    
    @IBAction func callMenu(_ sender: Any) {
        callMenuDelegate?.changeview(forMenuOption: nil)
    }
    
    
    
}


extension PlantViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sensorDevices = sensorDevices {
            return sensorDevices.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OptionTable.dequeueReusableCell(withIdentifier: "OptionTableViewCell", for: indexPath) as! OptionTableViewCell
        if let sensorDevices = sensorDevices{
            cell.setData(device: sensorDevices[indexPath.row])
            //            cell.device = sensorDevices[indexPath.row]
            //            cell.nhietdoLb.text = "\(sensorDevices[indexPath.row].indices![0].value ?? 0)"
            //            cell.phLb.text = "\(sensorDevices[indexPath.row].indices![2].value ?? 0)"
            //            cell.doamLb.text = "\(sensorDevices[indexPath.row].indices![3].value ?? 0)"
            //            cell.namePlant.text = "\(sensorDevices[indexPath.row])"
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailView = MainStoryBoard.instantiateViewController(identifier: "DetailInformationViewController") as? DetailInformationViewController{
            if let navigator = navigationController{
                detailView.section = indexPath.row
                navigator.pushViewController(detailView, animated: true)
            }
            
        }
        
    }
}

