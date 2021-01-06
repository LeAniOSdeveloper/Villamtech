//
//  DeleteGardenTableViewCell.swift
//  VillamTech
//
//  Created by Ân Lê on 5/31/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit
import iOSDropDown
protocol ReturnDataDeleteDelegate : class {
    func dataDetelte(data : Gardens)
}
class DeleteGardenTableViewCell: UITableViewCell, UITextFieldDelegate {
    var urlString  : LinkAPI_http?
    var api : GardenAPI?
    weak var deleteDelegate :ReturnDataDeleteDelegate?
    var  gardens: [Garden] = []{
        didSet{
            
            
        }
        
    }
    var idGarden : String?
    
    
    @IBOutlet weak var gardenDropDown: DropDown!
    @IBOutlet weak var deleteBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        urlString = LinkAPI_http()
        gardenDropDown.placeholder = "Tên vườn rau"
        
//        print(arrtempName)
//        //            gardenDropDown.optionIds = arrtempNa
//        gardenDropDown.selectedRowColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
//        for index in gardens {
//            arrtempName.append(index.name)
//            arrtempId.append(index.gardenId)
//        }
        gardenDropDown.selectedRowColor = #colorLiteral(red: 0.02382025123, green: 0.4248794019, blue: 0.01854708791, alpha: 1)
//        gardenDropDown.optionArray = arrtempName
//
//        gardenDropDown.didSelect{(selectedText , index ,id) in
//            let path : GARDENAPI = GARDENAPI(idGarden: arrtempId[index])
//            GardenAPI(path: path.POST_DELETEGARDEN ).deleteGarden(gardenId: path.POST_DELETEGARDEN, tokenId: "") { (data) in
//                print(data)
//            }
//
//        }
        
        setup()
        
    }
    @IBAction func deleteAction(_ sender: Any) {
        gardenDropDown.text = ""
        guard let idGarden = idGarden else {
            return
        }
        let path : GARDENAPI = GARDENAPI(idGarden: idGarden)
        GardenAPI(path: path.POST_DELETEGARDEN ).deleteGarden(gardenId: path.POST_DELETEGARDEN, tokenId: "") { (data) in
            print(data)
            let alert = UIAlertController(title: "Xoá", message: "Xoá thành công", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Thoát", style: .default, handler: nil))
            
        }
        guard let urlstring = urlString else {return }
        api = GardenAPI(path: urlstring.GET_GARDEN)
        guard let api = api else {
            return
        }
        api.getGarden { (data) in
            var tempName : [String] = []
            for index in data.result {
                tempName.append(index.name)
            }
            self.gardenDropDown.optionArray = tempName
            self.deleteDelegate?.dataDetelte(data: data)
        }
    }
    func setup()  {
        
        
        deleteBtn.layer.cornerRadius = 5
        deleteBtn.setTitle("Xoá", for: .normal)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

