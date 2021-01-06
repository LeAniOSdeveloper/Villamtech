//
//  DetailInformationViewController.swift
//  VillamTech
//
//  Created by Ân Lê on 5/25/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit
import Foundation
enum OptionDetail : Int {
    
    
    case temperature
    case ec
    case ph
    
//    var name : String {
//        switch self {
//        case .parameter : return "DetailTableViewCell"
//        case .setting: return "SettingTableViewCell"
//        case .mapLb: return ""
//        }
//    }
    var img: String {
        switch self {
        case .temperature:
            return "weather"
        case .ec:
            return ""
        case.ph :
            return "ph-metro"
        }
    }
}


class DetailInformationViewController: UIViewController {
//    1: parameter 2 : setting 3 : map
    var controlcelltable :Int? {
        didSet{
            table.reloadData()
        }
    }
    var numberofcell = 3
    @IBOutlet weak var onloffBtn: UILabel!
    var arrayDatareponse: [String] = ["hello","hello1"]
    var data : ((Int)->())? = nil
    var value :Int?
    var section : Int = 0
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var parameter: UILabel!
    @IBOutlet weak var mapLb: UILabel!
    @IBOutlet weak var setting: UILabel!
    @IBOutlet weak var PlantNameLb: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //        dataLabel.text = "\(section)"
        settup()
        setupTapgestureForLable()
        table.delegate = self
        table.dataSource = self
        controlcelltable = 1
//        table.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
        // Do any additional setup after loading the view.
    }
    func settup (){
        PlantNameLb.layer.borderColor = #colorLiteral(red: 0, green: 0.6505013704, blue: 0.2597808838, alpha: 1)
        PlantNameLb.layer.cornerRadius = 5
        PlantNameLb.layer.borderWidth = 1
        self.parameter.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1), thickness: 5)
        self.parameter.textColor = #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1)
        self.mapLb.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), thickness: 5)
        self.mapLb.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.setting.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), thickness: 5)
        self.setting.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        onloffBtn.layer.cornerRadius = 5
        
    }
    
    func setupTapgestureForLable(){
        let tapParameter = UITapGestureRecognizer(target: self, action: #selector(tappesParameter))
        let tapMapLb = UITapGestureRecognizer(target: self, action: #selector(tappesMapLb))
        let tapSetting = UITapGestureRecognizer(target: self, action: #selector(tappesSetting))
        
        self.parameter.isUserInteractionEnabled = true
        self.mapLb.isUserInteractionEnabled = true
        self.setting.isUserInteractionEnabled = true
        self.parameter.addGestureRecognizer(tapParameter)
        self.mapLb.addGestureRecognizer(tapMapLb)
        self.setting.addGestureRecognizer(tapSetting)
        
        
        
    }
    @objc func tappesParameter(){
        self.parameter.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1), thickness: 5)
        self.parameter.textColor = #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1)
        self.mapLb.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), thickness: 5)
        self.mapLb.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.setting.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), thickness: 5)
        self.setting.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        controlcelltable = 1
        
    }
    @objc func tappesMapLb(){
        self.mapLb.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1), thickness: 5)
        self.mapLb.textColor = #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1)
        self.parameter.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), thickness: 5)
        self.parameter.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.setting.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), thickness: 5)
        self.setting.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        controlcelltable = 3
    }
    @objc func tappesSetting(){
        self.setting.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1), thickness: 5)
        self.setting.textColor = #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1)
        self.parameter.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), thickness: 5)
        self.parameter.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.mapLb.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), thickness: 5)
        self.mapLb.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        controlcelltable = 2
    }
    
    
}
extension DetailInformationViewController : UITableViewDelegate ,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if controlcelltable == 1 {
            return 130
        }
        else{
            return 150
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberofcell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = OptionDetail(rawValue: indexPath.row )
        if controlcelltable == 1 {
            if let cell = table.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as? DetailTableViewCell {
                cell.imgLogo.image = UIImage(named: option?.img ?? "villamTechLogo")
                return cell
            }
            
        }
        else if controlcelltable == 2 {
            if let cell = table.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell {
                return cell
            }
        }
            return UITableViewCell()
    }
    
    
    
}
