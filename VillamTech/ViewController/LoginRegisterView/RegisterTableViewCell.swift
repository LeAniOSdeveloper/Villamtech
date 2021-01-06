//
//  RegisterTableViewCell.swift
//  VillamTech
//
//  Created by Ân Lê on 3/19/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterTableViewCell: UITableViewCell {
    var presentClusre : ((_ alert : UIAlertController)->())? = nil
    var presentRegisterClurse : ((_ alert : UIAlertController)->())? = nil
    @IBOutlet weak var ticket: StickButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var repassTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var addressTf: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setup(){
        repassTf.baseStyle(placeholder: "Nhập lại mật khẩu")
        passwordTf.baseStyle(placeholder: "Mật khẩu ít nhất 6 kí tự")
        phoneTf.baseStyle(placeholder: "Số điện thoại")
        addressTf.baseStyle(placeholder: "Địa chỉ")
        emailTF.baseStyle(placeholder: "Email ")
        registerBtn.baseStyle(title: "Đăng ký ", background: #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1), borderWitdh: 0)
    }
    var checkTicket : Bool = false
    @IBAction func tickCondition(_ sender: Any) {
        if ticket.isChecked == true {
            checkTicket = true
        }
    }
    func checkEmail(email : String)->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func checkPassword(pass : String)->Bool{
        if pass.count >= 6 {
            if (pass != emailTF.text!){
                return true
                
            }
            else {
                let alert = UIAlertController(title: "", message: "Mật khẩu không được trùng Email", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Thoát", style: .cancel, handler: nil))
                presentClusre!(alert)
                return false
            }
        }
        return false
        
    }
    @IBAction func register(_ sender: Any) {
        if !checkTicket {
            
            if emailTF.text != nil  || emailTF.text != ""{
                if checkEmail(email: emailTF.text!){
                    if passwordTf.text != nil || passwordTf.text != ""{
                        if checkPassword(pass : passwordTf.text!){
                            
                            if repassTf.text != nil || repassTf.text != "" {
                                if repassTf.text == passwordTf.text {
                                    print(emailTF.text!)
                                    
                                    
                                    
//                                    print(providers)
                                    Auth.auth().createUser(withEmail: self.emailTF.text!, password: self.passwordTf.text!) { authResult, error in
                                        if error == nil {
                                            //                                                    emailTF.text! ==""
                                            //                                                    passwordTf.text! == ""
                                            
                                            let alert = UIAlertController(title: "Đăng ký thành công", message: "", preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "Thoát", style: .cancel, handler: nil))
                                            self.presentRegisterClurse!(alert)
                                            //                                                    print("success")
                                        }
                                        else {
                                            if let x = error {
                                                let err = x as NSError
                                                switch err.code {
                                                case AuthErrorCode.wrongPassword.rawValue:
                                                   print("wrong password")
                                                case AuthErrorCode.invalidEmail.rawValue:
                                                   print("invalid email")
                                                case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                                                   print("accountExistsWithDifferentCredential")
                                                case AuthErrorCode.emailAlreadyInUse.rawValue: //<- Your Error
                                                   
                                                    let alert = UIAlertController(title: "Email đã được sử dụng", message: "", preferredStyle: .alert)
                                                    alert.addAction(UIAlertAction(title: "Thoát", style: .cancel, handler: nil))
                                                    self.presentClusre!(alert)
                                                default:
                                                   print("unknown error: \(err.localizedDescription)")
                                                }
                                            }
                                        }
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                else {
                                    let alert = UIAlertController(title: "", message: "mật khẩu không khớp", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Thoát", style: .cancel, handler: nil))
                                    presentClusre!(alert)
                                }
                            }
                        }
                        
                    }
                    else{
                        let alert = UIAlertController(title: "", message: "Bạn chưa nhâp mật khẩu", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Thoát", style: .cancel, handler: nil))
                        presentClusre!(alert)
                    }
                }
                else {
                    if emailTF.text == nil || emailTF.text == "" {
                        let alert = UIAlertController(title: "Bạn chưa nhâph Email", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Thoát", style: .cancel, handler: nil))
                        presentClusre!(alert)
                    }else {
                        let alert = UIAlertController(title: "Email không hợp lệ", message: "Email không hợp lệ", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Thoát", style: .cancel, handler: nil))
                        presentClusre!(alert)
                    }
                    
                }
            }
            else {
                let alert = UIAlertController(title: "", message: "Bạn chưa nhâp email", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Thoát", style: .cancel, handler: nil))
                presentClusre!(alert)
            }
            
            //            Auth.auth().createUser(withEmail: emailTF, password: password) { authResult, error in
            // ...
            //        }
        }
        else {
            let alert = UIAlertController(title: "", message: "Bạn chưa đồng ý điều khoản", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Thoát", style: .cancel, handler: nil))
            presentClusre!(alert)
        }
    }
}
