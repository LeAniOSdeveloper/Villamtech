//
//  Wifi.swift
//  VillamTech
//
//  Created by Ân Lê on 8/9/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation
struct WifiInfo {
    public let interface:String
    public let ssid:String
    public let bssid:String
    init(_ interface:String, _ ssid:String,_ bssid:String) {
        self.interface = interface
        self.ssid = ssid
        self.bssid = bssid
    }
}
