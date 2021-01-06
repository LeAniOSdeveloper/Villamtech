//
//  Garden.swift
//  VillamTech
//
//  Created by Ân Lê on 6/12/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation

struct Garden : Codable{
    
    
//    var token : String
    
    var gardenId : String
    var name : String
    var address: String
    var creationDate : String
    var cropInfo : [CropInfo?]
    init( gardenId : String , name : String , address: String , creationDate : String  , cropInfo : [CropInfo]) {
//        self.token = token
        self.gardenId = gardenId
        self.name = name
        self.address = address
        self.creationDate = creationDate
        self.cropInfo = cropInfo
    }
}

struct Gardens : Codable {
    var result : [Garden]
    var errorMessage : String?
    var timeGenerated : String
}

struct CropInfo:Codable {
    var cropId: String
    var espControllerId : String
    var gardenId : String
    var plantId : String
    var planName : String
    var description : String
    var creationData: String
    var planedStartDate :  String
    var planedEndDate : String
    var startDate : String
}

struct GarderRequest :Codable{
    var result :String?
    var errorMessage : String?
    var timeGenerated : String
}

