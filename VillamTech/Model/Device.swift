//
//  Device.swift
//  VillamTech
//
//  Created by Ân Lê on 7/4/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation
struct SensorRecord:Codable {
    var result : [Device]
    var errorMessage: String?
    var timeGenerated : String
    
}
struct Device : Codable{
    var deviceId : String
    var planName : String
    var indices : [Indice]
    var creationDate: String
    var isDiconnected : Bool
   
}
struct DeviceRequest : Codable {
    var gardenId: String
    var deviceId : String
    var planname : String
    var config : [ConfigDevice]
}
struct  ConfigDevice: Codable {
    var type : String
    var  min : Double
    var max : Double
}
struct DeviceReponse : Codable{
     var result : Bool
       var errorMessage: String?
       var timeGenerated : String
}
struct Indice :Codable{
    var type : String?
    var value :Double?

    var min : Double?
    var max : Double?
}
