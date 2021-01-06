//
//  DropdownButton.swift
//  VillamTech
//
//  Created by Ân Lê on 4/16/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation
import UIKit
class DropdownButton : UIButton,dropdownProtocol{
    func dropdowpassing(title: String) {
        self.setTitle(title, for: .normal)
        dissmissDropDown()
    }
    
    var dropdownview = DropDownView()
    var height = NSLayoutConstraint()
    override func layoutSubviews() {
        super.layoutSubviews()
        dropdownview = DropDownView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        self.setImage(UIImage(named: "icons8-chevron-down-50"), for: .normal)
        let imag = UIImageView(image: UIImage(named: "icons8-chevron-down-50"))
        addSubview(imag)
        imag.translatesAutoresizingMaskIntoConstraints = false
        imag.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imag.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imag.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        imag.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        dropdownview.translatesAutoresizingMaskIntoConstraints = false
        self.superview?.addSubview(dropdownview)
        self.superview?.bringSubviewToFront(dropdownview)
        dropdownview.delegate = self
        dropdownview.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropdownview.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropdownview.widthAnchor.constraint(equalTo:self.widthAnchor).isActive = true
        height = dropdownview.heightAnchor.constraint(equalToConstant:  0)
        
        
        
        
    }
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false{
            isOpen = true
            NSLayoutConstraint.deactivate([self.height])
//            self.height.constant = 150
            if dropdownview.tableDrop.contentSize.height > 150{
                self.height.constant = 150
            }
            else{
                self.height.constant = self.dropdownview.tableDrop.contentSize.height
            }
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.dropdownview.layoutIfNeeded()
              
            }, completion: nil)
        }
        else {
            isOpen = false
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                  self.dropdownview.center.y -= self.dropdownview.frame.height/2
                self.dropdownview.layoutIfNeeded()
                
            }, completion: nil)
            
        }
    }
    func dissmissDropDown()  {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
              self.dropdownview.center.y -= self.dropdownview.frame.height/2
            self.dropdownview.layoutIfNeeded()
            
        }, completion: nil)
    }
    
}

protocol dropdownProtocol {
    func dropdowpassing(title :String)
}
class DropDownView : UIView ,UITableViewDelegate,UITableViewDataSource{
    
    var dropDownOption:[String] = ["con cho","con meo","con bo","hellomoder"]
    var tableDrop  = UITableView()
    var delegate : dropdownProtocol?
    override init(frame: CGRect) {
        
        super.init(frame:frame)
        tableDrop.delegate = self
        tableDrop.dataSource = self
        tableDrop.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableDrop)
        tableDrop.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableDrop.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableDrop.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableDrop.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dropDownOption[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.dropdowpassing(title: dropDownOption[indexPath.row])
    }
}
