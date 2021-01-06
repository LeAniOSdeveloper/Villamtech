//
//  MenuOption.swift
//  VillamTech
//
//  Created by Ân Lê on 5/6/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation
import  UIKit
enum MenuOption: Int,CustomStringConvertible {
    
    case  BangTheoGioi
    case CaiDatVuonRau
    case  Wifi
    case  TaiKhoan
    case  DangXuat
    var description : String {
        switch self {
        case .BangTheoGioi: return "Bảng Theo Dỏi"
        case .CaiDatVuonRau: return "Cài Đặt Vườn Rau"
        case .Wifi: return "Kết Nói Wifi Cho Thiết Bị"
        case .TaiKhoan :return "Tài Khoản"
        case .DangXuat: return "Đăng Xuất "
        }
    }
    var image : UIImage {
        switch self {
        case .BangTheoGioi: return UIImage(named: "icons8-database-60")!
        case .CaiDatVuonRau: return UIImage(named: "icons8-settings-50")!
        case .Wifi: return UIImage(named: "icons8-wi-fi-50")!
        case .TaiKhoan :return UIImage(named: "icons8-user-48")!
        case .DangXuat: return UIImage(named: "icons8-shutdown-50")!
        }
    }
    
    
}
