//
//  LoginTableViewCell.swift
//  VillamTech
//
//  Created by Ân Lê on 3/19/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit

class LoginTableViewCell: UITableViewCell {
    var apiGarden : GardenAPI?
    var path = LinkAPI_http()
    var loginPushDelegate : (()->())? = nil
    var user: User = User()
    @IBOutlet weak var stickedBtn: StickButton!
    @IBOutlet weak var passwordImg: UIImageView!
    @IBOutlet weak var emailImg: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var fbBtn: UIButtonImage!
    @IBOutlet weak var emailName: UILabel!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var password: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTapGesture()
        setup()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(){
        
        emailTf.baseStyle(placeholder: "Email")
        password.baseStyle(placeholder: "Mật khẩu ít nhất 6 kí tự ")
        let image = UIImage(named: "fbIcon")
        fbBtn.setImage(image, for: .normal)
        fbBtn.baseStyle(title: "Đăng nhập bằng Facebook ", background: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), borderWitdh: 1)
        loginBtn.baseStyle(title: "Đăng nhập ", background: #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1) , borderWitdh: 0 )
    }
    func setupTapGesture(){
        
        emailTf.addTarget(self, action: #selector(tapEmailTf), for: UIControl.Event.editingDidBegin)
        emailTf.addTarget(self, action: #selector(tapEmailEnd), for: UIControl.Event.editingDidEnd)
        password.addTarget(self, action: #selector(tapPassStart), for: UIControl.Event.editingDidBegin)
        password.addTarget(self, action: #selector(tapPassEnd), for: UIControl.Event.editingDidEnd)
        
    }
    @objc func tapEmailTf(){
        emailTf.layer.borderColor = #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1)
        emailName.textColor = #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1)
    }
    @objc func tapEmailEnd(){
        emailTf.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        emailName.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    @objc func tapPassStart(){
        password.layer.borderColor = #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1)

    }
    @objc func tapPassEnd(){
        password.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

    }
    @IBAction func loginAc(_ sender: Any) {
//        if (emailTf.text ==  user.email && password.text == user.password){
//        GardenAPI.init(path: path.GET_GARDEN).getGarden { (garden ) in
//            print(garden)
//            self.loginPushDelegate!(garden)
//
//        }
            self.loginPushDelegate!()
//        }
        
    }
    
}
