//
//  MenuViewController.swift
//  VillamTech
//
//  Created by Ân Lê on 5/6/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var tapHidenBtn: UIButton!
    weak var menudelegate : HomeControllerDelegate?
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func tapChangeVIewOfBtn(_ sender: Any) {
        print("hello em")
    }
    

}
extension MenuViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.img.image = menuOption?.image
        cell.name.text = menuOption?.description
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        if menuOption != .DangXuat{
            menudelegate?.changeview(forMenuOption: menuOption)
            
        }
        else{
            let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
                           sceneDelegate?.Logout()
        }
    }
    
}
