//
//  UserViewController.swift
//  VillamTech
//
//  Created by Ân Lê on 4/20/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    weak var menudelegate : HomeControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        setupNavigtion()
    }
    
    
    @IBAction func callMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        menudelegate?.changeview(forMenuOption: nil)
    }
    func setupNavigtion(){
           navigationController?.navigationBar.topItem?.title = "Cài đặt vườn rau"
           
           navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :  UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.6505013704, blue: 0.2597808838, alpha: 1))]
           
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
