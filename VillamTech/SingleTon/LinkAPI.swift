//
//  LinkAPI.swift
//  VillamTech
//
//  Created by Ân Lê on 6/1/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation
struct LinkAPI{
//    /api/Devices/AddUpdateDevice
    static let GET_DEVICES_GETCONFIG = "https://api.villamtech.com/api/Devices/GetConfig"
    static let POST_DEVICES_UPDATACONFIG = "https://api.villamtech.com/api/Devices/UpdateConfig"
    static let GET_SENSORRECORD_GETVALUE = "https://api.villamtech.com/api/SensorRecords/GetValues?GadentId="
//    static let 
}
struct SENSORRECORD {
    static let sharing = SENSORRECORD()
    var post_AddUpdateDevice : String {
        return "https://api.villamtech.com/api/Devices/AddUpdateDevice"
    }
    public func get_SENSORRECORD_GETVALUE(gardenID : String , deviceId : String?)->String{
        if let deviceId = deviceId {
            return "https://api.villamtech.com/api/SensorRecords/GetValues?GadentId=" + gardenID + "&DeviceId="+deviceId
        }else {

            return "https://api.villamtech.com/api/SensorRecords/GetValues?GadentId=" + gardenID
        }
    }
//    static let GET_SENSORRECORE_GETVALUE = "https://api.villamtech.com/api/SensorRecords/GetValues?GadentId="
//    public func GET_SENSORRECORE_GETVALUE
}
struct LinkAPI_http {
   
    var token : String?
    var GET_GARDEN : String {
        if let token = token {
           return  "http://api.villamtech.com:8000/api/Gardens" + "?" + token
        }
        else{
            return "http://api.villamtech.com:8000/api/Gardens"
        }
    }
    init (tokenID : String){
        self.token = tokenID
    }
    init() {
        
    }
}
struct GARDENAPI {
    var POST_ADDGARDEN = "https://api.villamtech.com/api/Gardens/AddGarden"
    var idGarden : String?
    init( idGarden : String ){
        self.idGarden = idGarden
    }
    init() {
        
    }
    var POST_DELETEGARDEN : String{
        if let idGarden = idGarden {
            return "https://api.villamtech.com/api/Gardens/DeleteGarden?GardenId=" + idGarden
        }
        else {
            return "https://api.villamtech.com/api/Gardens/DeleteGarden"
        }
    }
}
