//
//  ContainerViewController.swift
//  VillamTech
//
//  Created by Ân Lê on 5/4/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    weak var centerController : UIViewController!
    weak var menuViewcontroller : MenuViewController!
    var button : UIButton! = UIButton()
    var data_Garden : Gardens?
    var isExpanded = false
    let path = LinkAPI_http()
    var userToken : String?
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GardenAPI.init(path: path.GET_GARDEN).getGarden { (garden ) in
            print(garden)
            self.data_Garden = garden

        }
       
        self.configMainView ()
        self.configMenuViewController()
        
        
        // Do any additional setup after loading the view.
    }
    
    func configMainView(){
        let plantViewController = MainStoryBoard.instantiateViewController(withIdentifier: "PlantViewController" ) as! PlantViewController
        plantViewController.callMenuDelegate = self
        centerController = BaseNavigationViewController(rootViewController: plantViewController)
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
        
    }
    func configMenuViewController(){
        if menuViewcontroller == nil{
            let menu = MainStoryBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            menu.menudelegate = self
            view.insertSubview(menu.view, at: 0)
            addChild(menu)
            menu.didMove(toParent: self)
            
        }
        
    }
    func showmenu(shouldEx : Bool,menuOption : MenuOption?){
        if shouldEx {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
                
                self.centerController.view.addSubview(self.button)
                self.button.backgroundColor = .clear
                self.button.translatesAutoresizingMaskIntoConstraints = false
                self.button.leftAnchor.constraint(equalTo: self.centerController.view.leftAnchor, constant: 0).isActive = true
                self.button.widthAnchor.constraint(equalToConstant: 80).isActive = true
                self.button.topAnchor.constraint(equalTo: self.centerController.view.topAnchor, constant: 0   ).isActive = true
                self.button.bottomAnchor.constraint(equalTo: self.centerController.view.bottomAnchor, constant: 0   ).isActive = true
                self.button.addTarget(self, action: #selector(self.touchDropView), for: .touchUpInside)
                
            }, completion: nil)
            
        }else{
            
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }) { (_) in
                
                guard let menuOp = menuOption else{return }
                self.didselecOptionView(menuOption: menuOp)
                
            }
            
        }
        //        animationStatusBar()
        
        
        
    }
    @objc func touchDropView(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerController.view.frame.origin.x = 0
            self.button.isHidden = true
            self.isExpanded = !self.isExpanded
        }, completion: nil)
    }
    func didselecOptionView(menuOption : MenuOption){
        switch  menuOption {
        case .BangTheoGioi:
//            plantViewController.dataGardens = data_Garden
            print("BangTheoGioi")
            self.button.isHidden = true
        case .CaiDatVuonRau:
            let caidat = MainStoryBoard.instantiateViewController(withIdentifier: "SettingViewController") as!SettingViewController
            caidat.menudelegate = self
            guard let data_Garden = data_Garden else {
                return
            }
            print(data_Garden.result)
            caidat.gardensData = data_Garden.result
            let navCaidat = UINavigationController(rootViewController: caidat)
            
            navCaidat.modalPresentationStyle = .fullScreen
            
            present(navCaidat, animated: true, completion: nil)
            
        case .Wifi:
            print("Wifi")
            let wifi = MainStoryBoard.instantiateViewController(withIdentifier: "WifiViewController") as! WifiViewController
            wifi.menudelegate = self
            let nav = UINavigationController.init(rootViewController: wifi)
            //            let nawifi = UINavigationController.
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true, completion: nil)
        case .TaiKhoan:
            print("TaiKhoan")
            let taikhoan = MainStoryBoard.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
            taikhoan.menudelegate = self
            let navTaiKhoan = UINavigationController(rootViewController: taikhoan)
            navTaiKhoan.modalPresentationStyle = .fullScreen
            present(navTaiKhoan, animated: true, completion: nil)
        case .DangXuat:
            print("DangXuat")
            
        }
    }
    func animationStatusBar(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
        
    }
}
extension ContainerViewController: HomeControllerDelegate{
    func changeview(forMenuOption menuOption: MenuOption?) {
        if !isExpanded {
            //            configMenuViewController()
            
            self.button.isHidden = true
            
        }
        
        isExpanded = !isExpanded
        
        showmenu(shouldEx: isExpanded, menuOption: menuOption)
        self.button.isHidden = false
        
    }
    
    
    
}
