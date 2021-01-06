//
//  LoginRegisterView.swift
//  VillamTech
//
//  Created by Ân Lê on 3/16/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit
import FirebaseAuth
class LoginRegisterView: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    //    var pageMenu : CAPSPageMenu?
    @IBOutlet weak var emailName: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var loginLb: UILabel!
    @IBOutlet weak var registerLb: UILabel!
    var bienthaydoisection : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        setupLogo()
        setupTapgestureForLable()
        hideKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
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
    
    func setupLogo(){
        logoImg.image = UIImage(named: "villamTechLogo")
        self.loginLb.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1), thickness: 5)
        self.loginLb.textColor = #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1)
        self.registerLb.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.registerLb.text = "ĐĂNG KÝ"
        self.registerLb.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), thickness: 5)
    }
    @objc func tapgestureForLoginLb(sender : UITapGestureRecognizer){
        self.loginLb.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1), thickness: 5)
        self.loginLb.textColor = #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1)
        self.registerLb.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.registerLb.text = "ĐĂNG KÝ"
        self.registerLb.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), thickness: 5)
        
        //        self.registerLb.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        bienthaydoisection = true
        table.reloadData()
    }
    @objc func tapgestureForRegister(sender : UITapGestureRecognizer){
        self.registerLb.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1), thickness: 5)
        self.registerLb.textColor = #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1)
        self.loginLb.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.loginLb.text = "ĐĂNG NHẬP"
        //        self.loginLb.layer.clearBorder()
        self.loginLb.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), thickness: 5)
        //        self.loginLb.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        bienthaydoisection = false
        table.reloadData()
    }
    @objc func tapgestureEmailLb(sender : UITapGestureRecognizer){
        emailTf.layer.borderColor = #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1)
        emailName.textColor = #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1)
        print("hello")
    }
    func setupTapgestureForLable(){
        let tapgestureLogin = UITapGestureRecognizer(target: self, action: #selector(tapgestureForLoginLb))
        let tapgestureRegister = UITapGestureRecognizer(target: self, action: #selector(tapgestureForRegister))
        self.loginLb.isUserInteractionEnabled = true
        self.registerLb.isUserInteractionEnabled = true
        self.loginLb.addGestureRecognizer(tapgestureLogin)
        self.registerLb.addGestureRecognizer(tapgestureRegister)
        
        
    }
}
extension LoginRegisterView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let segment = UISegmentedControl()
    //        return segment
    //    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if bienthaydoisection == true {
            return self.table.frame.height
        }
        else {
            return 600
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if bienthaydoisection == true {
            guard let loginview = table.dequeueReusableCell(withIdentifier: "LoginTableViewCell", for: indexPath) as? LoginTableViewCell else {
                return UITableViewCell()
            }
            //
            loginview.loginPushDelegate = {  () in
                let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
                print((loginview.emailTf.text ?? "") + " day la email Login")
                print((loginview.password.text ?? "") + " day la password ")
                if (loginview.emailTf.text == nil  || loginview.emailTf.text == "") {
                    let alert = UIAlertController(title: "Lỗi :(", message: "Bạn chưa nhập Email", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Thoát", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else {
                    if (loginview.password.text == nil  || loginview.password.text == ""){
                        let alert = UIAlertController(title: "Lỗi :(", message: "Bạn chưa nhập Mật Khẩu", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Thoát", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else {
                        Auth.auth().signIn(withEmail: loginview.emailTf.text ?? "" , password: loginview.password.text ?? "") { [weak self] authResult, error in
                            if (error == nil){
                                
                                let user = Auth.auth().currentUser
                                user?.getIDToken(completion: { (id, err) in
                                    //                                    let user = UserDefaults.standard
                                    //                                    user.
                                    standardUserDefaults.set(id, forKey: "token")
                                    sceneDelegate?.Login(  token: id )
                                })
                                
                            }
                            else {
                                print(error)
                                let alert = UIAlertController(title: "Lỗi :(", message: "Tài khoản hoặc mật khẩu không đúng ", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Thoát", style: .cancel, handler: nil))
                                self!.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                    
                    
                    
                    // ...
                }
                
                
                
                
            }
            return loginview
            
        }
        else {
            guard let register = table.dequeueReusableCell(withIdentifier: "RegisterTableViewCell", for: indexPath) as? RegisterTableViewCell else {
                
                return UITableViewCell()
            }
            
            register.presentClusre = {  alert in
                self.present(alert, animated: true, completion: nil)
            }
            register.presentRegisterClurse = { alert in
                self.present(alert, animated: true) {
                    self.bienthaydoisection = true
                    self.loginLb.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1), thickness: 5)
                    self.loginLb.textColor = #colorLiteral(red: 0, green: 0.5138283968, blue: 0, alpha: 1)
                    self.registerLb.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                    //            self.registerLb.text = "ĐĂNG KÝ"
                    self.registerLb.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), thickness: 5)
                    self.table.reloadData()
                }
            }
            return register
        }
    }
    
    
}

