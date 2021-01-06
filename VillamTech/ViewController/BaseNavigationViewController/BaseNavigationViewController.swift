//
//  BaseNavigationViewController.swift
//  VillamTech
//
//  Created by Ân Lê on 4/9/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    weak var menudelegate : HomeControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
                navigationBar.barTintColor = .white
                navigationBar.tintColor = .green
//        let navitem = UINavigationItem()
    
//        navigationBar.setItems([navitem], animated: true)
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//
//        navigationController?.navigationBar.topItem?.title = "some title"
//
    }
    @objc func menuCall() {
        dismiss(animated: true, completion: nil)
              menudelegate?.changeview(forMenuOption: nil)
    }
    
    
    
}
