//
//  SlideSetting.swift
//  VillamTech
//
//  Created by Ân Lê on 5/8/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation
enum ItemSlideOption : Int {
    
    
    case ChinhSua
    case TaoVuon
    case ThemThietBi
    case XoaThietBi
    case XoaVuon
    var name : String {
        switch self {
        case .ChinhSua : return "CHỈNH SỬA THÔNG TIN VƯỜN RAU"
        case .TaoVuon: return "TẠO VƯỜN"
        case .ThemThietBi: return "THÊM THIÊT BỊ"
        case .XoaThietBi: return "XOÁ THIẾT BỊ"
        case .XoaVuon: return "XOÁ VƯỜN"
        }
    }
    var fileXibName : String {
        switch self {
        case .ChinhSua : return "SettingXib"
        case .TaoVuon: return "CreateYaldXib"
        case .ThemThietBi: return "CreateDeviceXib"
        case .XoaThietBi: return "DeleteDeviceXib"
        case .XoaVuon: return "DropYald"
        }
        
    }
}
struct SlideSetting  {
    var isShow : Bool
    
}
