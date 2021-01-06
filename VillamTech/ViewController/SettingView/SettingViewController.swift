//
//  SettingViewController.swift
//  VillamTech
//
//  Created by Ân Lê on 4/20/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    var data : [SlideSetting]?
    var gardensData : [Garden]? {
        didSet{
            if table != nil {
                table.reloadData()
                
            }
        }
    }
     var returndata : ((String)->())! = nil
    @IBOutlet weak var scrollView: UIScrollView!
    var nameArrGarden : [String] = []
//    @IBOutlet weak var scrollView: UITableView!
    @IBOutlet weak var table: UITableView!
    var isTurnOnCekkControl : [Bool] = [false,false,false,false,false]
    var tempSection:Int = 0
    weak var menudelegate : HomeControllerDelegate?
    let path = LinkAPI_http()
    var api : GardenAPI?
    override func viewWillAppear(_ animated: Bool) {
        api = GardenAPI(path: path.GET_GARDEN)
        api?.getGarden(completion: { (data) in
            self.gardensData = data.result
        })
//        hideKeyboard()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigtion()
        scrollView.gestureRecognizers?.removeAll()
//        table.gestureRecognizers
        table.delegate = self
        table.dataSource = self
        data = [SlideSetting(isShow: false),SlideSetting(isShow: false),SlideSetting(isShow: false),SlideSetting(isShow: false),SlideSetting(isShow: false)]
        // Do any additional setup after loading the view.
        table.register(UINib(nibName: "DropDeviceTableViewCell", bundle: nil), forCellReuseIdentifier: "cellDrop")
        table.register(UINib(nibName: "ChinhSuaCell", bundle: nil), forCellReuseIdentifier: "cellChinhSua")
        table.register(UINib(nibName: "TaoVuonRauTableViewCell", bundle: nil),forCellReuseIdentifier: "cellTaoVuon")
        table.register(UINib(nibName: "AddDeviceTableViewCell", bundle: nil), forCellReuseIdentifier: "cellAddDevice")
        table.register(UINib(nibName: "DeleteGardenTableViewCell", bundle: nil), forCellReuseIdentifier: "cellDeleteGarden")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        hideKeyboard()
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
        table.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        table.contentInset = contentInset
        
    }
    
    @IBAction func callMenuTabbar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        menudelegate?.changeview(forMenuOption: nil)
    }
    func setupNavigtion(){
        navigationController?.navigationBar.topItem?.title = "Cài Đặt Vườn Rau"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :  UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.6505013704, blue: 0.2597808838, alpha: 1))]
        
    }
    
}

extension SettingViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if !isTurnOnCekk {
        return 1
        //        }
        //        else{
        //             return 0
        //        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !isTurnOnCekkControl[indexPath.section] {
            
            return 0
        }
        else{
            
            switch indexPath.section {
            case 0:
                return 250
            case 1:
                return 200
            case 2:
                return 270
            case 3:
                return 200
            default:
                return 150
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         view.gestureRecognizers?.removeAll()
         hideKeyboard()
        switch indexPath.section {
        case 0 :
            let chinhsuaCell = table.dequeueReusableCell(withIdentifier: "cellChinhSua", for: indexPath) as! ChinhSuaCell
            guard let gardensData = gardensData else{
                           return chinhsuaCell
                       }
            var temp : [String] = []
            var tempIds : [String] = []
            for x in gardensData {
                temp.append(x.name)
                tempIds.append(x.gardenId)
            }
            chinhsuaCell.gardenTf.selectedRowColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
            chinhsuaCell.reloadUpdateGarden = self
            chinhsuaCell.gardenTf.optionArray = temp
            
            chinhsuaCell.gardenTf.didSelect { (selectedText , index ,id) in
                chinhsuaCell.idGarden = tempIds[index]
                
            }
            return chinhsuaCell
        case 1:
            let taovuonCell = table.dequeueReusableCell(withIdentifier: "cellTaoVuon", for: indexPath) as!TaoVuonRauTableViewCell
            taovuonCell.alertDelegate = self
           guard let gardensData = gardensData else{
                          return taovuonCell
                      }
            for index in gardensData {
                nameArrGarden.append(index.name)
            }
            taovuonCell.nameArrGarden = nameArrGarden
            
//            hideKeyboard()
            return taovuonCell
        case 2:
            if let cellAddDevice = table.dequeueReusableCell(withIdentifier: "cellAddDevice", for: indexPath) as? AddDeviceTableViewCell{
//                cellAddDevice.chooseGarden
                cellAddDevice.pushviewDelegate = self
                guard  let  gardensData = gardensData else {
                    return cellAddDevice
                }
                print(gardensData)
                cellAddDevice.dataGarden = gardensData
                var temp : [String] = []
                var tempIds : [String] = []
                for x in gardensData {
                    temp.append(x.name)
                    tempIds.append(x.gardenId)
                }
                returndata = {idDevice in
                    cellAddDevice.idDevice.text = idDevice
                }
                cellAddDevice.chooseGarden.optionArray = temp
                cellAddDevice.chooseGarden.selectedRowColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
                
                cellAddDevice.alertdelegate = self
                //                    let cameraQR = MainStoryBoard.instantiateViewController(identifier: "QRScanViewController")
                //                    self.navigationController?.pushViewController(cameraQR, animated: true)
                cellAddDevice.chooseGarden.didSelect { (selectedText , index ,id) in
                    cellAddDevice.idGarden = tempIds[index]
                }
                return cellAddDevice
            }
            return UITableViewCell()
        case 3:
            let dropView = table.dequeueReusableCell(withIdentifier: "cellDrop", for: indexPath) as! DropDeviceTableViewCell
            
            guard let gardensData = gardensData else{
                           return dropView
                       }
            var temp : [String] = []
            var tempIds : [String] = []
            for x in gardensData {
                temp.append(x.name)
                tempIds.append(x.gardenId)
            }
            print(tableView.headerView(forSection: indexPath.section)?.gestureRecognizers)
//            dropView.gardenTf.isUserInteractionEnabled = true
            dropView.gardenTf.optionArray = temp
            dropView.gardenTf.selectedRowColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
            view.gestureRecognizers?.removeAll()
            
            dropView.gardenTf.didSelect {(selectedText , index ,id) in
                var request = SensorRecordsAPI(path: SENSORRECORD.sharing.get_SENSORRECORD_GETVALUE(gardenID: tempIds[index], deviceId: ""))
                request.getSensorRecords { (sensor) in
                    var tempSensorName :[String] = []
                    guard let sensor = sensor else {
                        return
                    }
                    for x in sensor.result{
                        tempSensorName.append(x.deviceId)
                    }
                    dropView.deviceTf.optionArray = tempSensorName
                    dropView.deviceTf.didSelect { (selectedText , index ,id) in
                        print(index)
                    }
                }

            }
            
            return dropView
        default:
            
            let cellDeleteGarden = table.dequeueReusableCell(withIdentifier: "cellDeleteGarden", for: indexPath) as! DeleteGardenTableViewCell
            guard  let  gardensData = gardensData else {
                return cellDeleteGarden
            }
            cellDeleteGarden.deleteDelegate = self
            cellDeleteGarden.gardens = gardensData
            var arrtempName  :[String] = []
           
           
            //            gardenDropDown.optionIds = arrtempNa
            var arrId:[String] = []
            for index in gardensData {
                arrtempName.append(index.name)
                arrId.append(index.gardenId)
            }
            cellDeleteGarden.gardenDropDown.selectedRowColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
            cellDeleteGarden.gardenDropDown.optionArray = arrtempName
//            cellDeleteGarden.gardenDropDown.optionIds = arrId
            cellDeleteGarden.gardenDropDown.didSelect { (selectedText , index ,id) in
//                let path : GARDENAPI = GARDENAPI(idGarden: arrId[index])
//                GardenAPI(path: path.POST_DELETEGARDEN ).deleteGarden(gardenId: path.POST_DELETEGARDEN, tokenId: "") { (data) in
//                    print(data)
//                }
                cellDeleteGarden.idGarden = arrId[index]
            }
            print(gardensData)
            return cellDeleteGarden
        }
        
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        let viewcontent = UIView()
        let lable = UILabel()
        let option = ItemSlideOption(rawValue: section)
        lable.text = option?.name
        lable.textColor = #colorLiteral(red: 0, green: 0.6505013704, blue: 0.2597808838, alpha: 1)
        lable.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        viewcontent.addSubview(lable)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.topAnchor.constraint(equalTo: viewcontent.topAnchor, constant: 10).isActive = true
        lable.leftAnchor.constraint(equalTo: viewcontent.leftAnchor, constant: 5).isActive = true
        lable.bottomAnchor.constraint(equalTo: viewcontent.bottomAnchor, constant: -10).isActive = true
        
        viewcontent.layer.borderWidth = 1
        viewcontent.layer.cornerRadius = 5
        viewcontent.layer.borderColor = #colorLiteral(red: 0.8979603648, green: 0.8980897069, blue: 0.8979321122, alpha: 1)
        view.addSubview(viewcontent)
        viewcontent.translatesAutoresizingMaskIntoConstraints = false
        viewcontent.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        viewcontent.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        viewcontent.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        viewcontent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        
        let tapRecognize = CustomUITapGestureRecognizer(target: self, action: #selector(handleTapHeader(sender: )))
        view.tag = section
        view.addGestureRecognizer(tapRecognize)
        return view
        
    }
    
    @objc func handleTapHeader(sender: CustomUITapGestureRecognizer){
        if isTurnOnCekkControl[sender.view?.tag ?? 0] == false{
            isTurnOnCekkControl[sender.view?.tag ?? 0] = true
            
            
        }else{
            isTurnOnCekkControl[sender.view?.tag ?? 0] = false
            
        }
        table.beginUpdates()
        
        table.endUpdates()
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let option = ItemSlideOption(rawValue: section)
        return option?.name
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tempSection = indexPath.section
        
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.gestureRecognizers?.removeAll()
//    }
//    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
//        view.gestureRecognizers?.removeAll()
//    }
    
}
extension SettingViewController : PushDelegate{
    func pushView() {
        
        let cameraQR = MainStoryBoard.instantiateViewController(identifier: "QRScanViewController")
        self.navigationController?.pushViewController(cameraQR, animated: true)
        
        
        
    }
    
    
}
extension SettingViewController:AlertDelegate{
    func callAlerSuccess(title: String , messager : String ) {
        let alert = UIAlertController(title: title , message: messager , preferredStyle: .alert)
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (act) in
            print("action destructive") //action khi nhấn nút Cancel
        }
        alert.addAction(alertActionCancel)
        api = GardenAPI(path: path.GET_GARDEN)
        api?.getGarden(completion: { (data) in
            self.gardensData = data.result
            self.table.reloadData()
        })
         
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func callAlert(nameofGarden: String) {
        
        let alert = UIAlertController(title: "Lỗi :(" , message: nameofGarden , preferredStyle: .alert)
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (act) in
            print("action destructive") //action khi nhấn nút Cancel
        }
        alert.addAction(alertActionCancel)
         
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
extension SettingViewController:ReturnDataDeleteDelegate{
    func dataDetelte(data: Gardens) {
        gardensData = data.result
    }
    
    
}
extension SettingViewController:reloadWhenUpdateGarden{
    func reload(data : [Garden]) {
//        navigationController?.popViewController(animated: true)
        let alert = UIAlertController(title: "Cập nhật thành công", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (al) in
            self.gardensData = data
        }))
        present(alert, animated: true, completion: nil)
       
//        table.reloadData()
        
    }
    
    
}
