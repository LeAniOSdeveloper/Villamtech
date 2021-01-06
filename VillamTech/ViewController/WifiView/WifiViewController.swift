//
//  WifiViewController.swift
//  VillamTech
//
//  Created by Ân Lê on 4/20/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit
//import LBTATools
import CoreLocation
import SystemConfiguration.CaptiveNetwork
class WifiViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var connectBtn: UIButton!
    @IBOutlet weak var nameWifi: UITextField!
    @IBOutlet weak var showhideImg: UIImageView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var nameOfEmailLb: UILabel!
    weak var menudelegate : HomeControllerDelegate?
    var locationManager: CLLocationManager?
    //    var scrollOffset : CGFloat = 0
    //    var distance : CGFloat = 0
    var ishidePasss = true
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigtion()
        setup()
        password.isSecureTextEntry = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        hideKeyboard()
        locationManager = CLLocationManager()
                locationManager?.delegate = self
                locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
        if #available(iOS 13.0, *) {
            let status = CLLocationManager.authorizationStatus()
            if status == .authorizedWhenInUse {
                
                updateWiFi()
            } else {
                locationManager?.delegate = self
                locationManager?.requestWhenInUseAuthorization()
            }
        } else {
            print( updateWiFi())
        }
        
    }
    func updateWiFi() {
        print("SSID: \(getSSID())")
        //        ssidLabel.text = getSSID()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            //            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            //                if CLLocationManager.isRangingAvailable() {
            //                    // do stuff
            //
            //                }
            //            }
            updateWiFi()
        }
        if status == .authorizedWhenInUse {
            updateWiFi()
            //                    var arrinfomation = getWifiInfo()
            //                                      print(arrinfomation)
        }
    }
    @objc func keyboardWillShow(notification:NSNotification){
        
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    func setup(){
        password.layer.borderWidth = 2
        password.layer.cornerRadius = 5
        password.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        nameWifi.layer.borderWidth = 2
        nameWifi.layer.cornerRadius = 5
        nameWifi.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        nameOfEmailLb.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        password.delegate = self
        connectBtn.layer.cornerRadius = 5
        connectBtn.setTitle("KẾT NỐI", for: .normal)
        let tapRec = UITapGestureRecognizer()
        showhideImg.isUserInteractionEnabled = true
        tapRec.addTarget(self, action: #selector(actionPassword))
        showhideImg.addGestureRecognizer(tapRec)
        
        //        self.nameWifi.isUserInteractionEnabled = true
        //        self.password.isUserInteractionEnabled = true
        nameWifi.addTarget(self, action: #selector(tapnameWifiStart), for: UIControl.Event.editingDidBegin)
        nameWifi.addTarget(self, action: #selector(tapnameWifiEnd), for: UIControl.Event.editingDidEnd)
        password.addTarget(self, action: #selector(passwordStart), for: UIControl.Event.editingDidBegin)
        password.addTarget(self, action: #selector(passwordEnd), for: UIControl.Event.editingDidEnd)
        
    }
    @objc func tapnameWifiStart(){
        nameWifi.layer.borderWidth = 2
        nameWifi.layer.cornerRadius = 5
        nameWifi.layer.borderColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
        nameOfEmailLb.textColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
    }
    @objc func tapnameWifiEnd(){
        nameWifi.layer.borderWidth = 2
        nameWifi.layer.cornerRadius = 5
        nameWifi.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        nameOfEmailLb.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    @objc func passwordStart(){
        password.layer.borderWidth = 2
        password.layer.cornerRadius = 5
        password.layer.borderColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
        
    }
    @objc func passwordEnd(){
        password.layer.borderWidth = 2
        password.layer.cornerRadius = 5
        password.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        
    }
    @objc func actionPassword (){
        if ishidePasss {
            password.isSecureTextEntry = false
            ishidePasss = false
            showhideImg.image = UIImage(named: "icons8-cbs-50")
        }
        else{
            password.isSecureTextEntry = true
            ishidePasss = true
            showhideImg.image = UIImage(named: "icons8-hide-48")
        }
        
    }
    @IBAction func callMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        menudelegate?.changeview(forMenuOption: nil)
    }
    
    func setupNavigtion(){
        navigationController?.navigationBar.topItem?.title = "Cài Đặt Wifi"
        ////        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orange]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :  UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.6505013704, blue: 0.2597808838, alpha: 1))]
        
    }
    func getSSID() -> String? {
        var ssid: String?
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        return ssid
    }
    func getWifiInfo() -> Array<WifiInfo> {
        guard let interfaceNames = CNCopySupportedInterfaces() as? [String] else {
            return []
        }
        let wifiInfo:[WifiInfo] = interfaceNames.compactMap{ name in
            guard let info = CNCopyCurrentNetworkInfo(name as CFString) as? [String:AnyObject] else {
                return nil
            }
            guard let ssid = info[kCNNetworkInfoKeySSID as String] as? String else {
                return nil
            }
            guard let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String else {
                return nil
            }
            return WifiInfo(name, ssid,bssid)
        }
        return wifiInfo
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension WifiViewController : CLLocationManagerDelegate{
    
}
