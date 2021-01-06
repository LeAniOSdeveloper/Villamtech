//
//  request.swift
//  VillamTech
//
//  Created by Ân Lê on 6/1/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import Foundation
import Alamofire
class GardenAPI{
    
    var path :  String?
    init(path :String){
        self.path = path
    }
    func getGarden(completion:@escaping (_ gardens: Gardens)->()){
        guard let path = path  else {
            return
        }
        guard let  url = URL(string: path) else {
            return
        }
        AF.request(url,method: .get).responseJSON { (response) in
            
            
            switch response.result {
            case .success(_):
                
                guard let data = response.data else {
                    return
                }
                let decoder = JSONDecoder()
                
                if let result = try? decoder.decode(Gardens.self, from: data) {
                    completion(result)
                }
            case .failure(_):
                print("fail to reponse ")
            }
            
        }
        
    }
    func addGarden( ID userId: String,nameGarden name : String ,idGarden : String, addressGarden  address : String , completion : @escaping (_ gardens: GarderRequest  )->())  {
        guard let path = path  else {
            return
        }
        guard let  url = URL(string: path) else {
            return
        }
        let parameter :  [String: String] = ["userId" : userId , "gardenId" : idGarden , "name" : name  , "address" : address ]
        
        AF.request(url,method: .post, parameters: parameter,encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(_):
                guard let data = response.data else {
                    return
                }
                let decoder = JSONDecoder()
                print(response)
                if let result = try? decoder.decode(GarderRequest.self, from: data) {
                    completion(result)
                }
                
                
            case .failure(_):
                print("fail to reponse ")
            }
            
        }
        
    }
    
    func deleteGarden(gardenId : String , tokenId : String   ,completion :  @escaping (_ garden : GarderRequest ) -> ()){
        guard let path = path else {
            return
        }
        guard let url = URL(string: path) else {
            return
        }
        AF.request(url, method: .post).responseJSON { (response) in
            switch response.result {
            case .success(_):
                guard let data = response.data else {
                    return
                }
                
                let decoder = JSONDecoder()
                if let result = try? decoder.decode(GarderRequest.self, from: data){
                    completion(result)
                }
                
            case .failure(_):
                print("fail to reponse ")
            }
            
            
            
            
        }
        
        
        
    }
    
    
}

struct DeviceAPI {
    //    func getSensorIndice (urlString : String, completion : (Garden? ) ){
    //
    //    }
}
struct SensorRecordsAPI {
    //    static let sharing = SensorRecordsAPI(path: )
    var path :  String?
    init(path :String){
        self.path = path
    }
    init(){
        
    }
    func getSensorRecords(completion:@escaping (_ sensorRecords: SensorRecord? )->()){
        
        guard let path = path  else {
            return
        }
        guard let  url = URL(string: path) else {
            return
        }
        AF.request(url,method: .get).responseJSON { (response) in
            switch response.result {
            case .success(_):
                guard let data = response.data else {
                    return
                }
                print([response.result])
                let decoder = JSONDecoder()
                if let result = try? decoder.decode(SensorRecord.self, from: data) {
                    print(result)
                    completion(result)
                }
                
            case .failure(_):
                print("fail to reponse ")
            }
            
            
            
            
            
            
//            if response.result.isSuccess{
//                guard let data = response.data else {
//                    return
//                }
//                print([response.result])
//                let decoder = JSONDecoder()
//                if let result = try? decoder.decode(SensorRecord.self, from: data) {
//                    print(result)
//                    completion(result)
//                }
//            }
        }
        
    }
    func addSensorRecord(device : DeviceRequest , completion : @escaping ( _ reponse : DeviceReponse)->()){
        guard let path = path else {
            return
        }
        guard let url = URL(string: path) else {
            return
        }
        var arrayconfig : [[String : Any]] = []
        for x in device.config {
            arrayconfig.append(["type" : x.type, "min" : x.min , "max":x.max])
        }
        print(arrayconfig)
        let parameter = ["gardenId" : device.gardenId, "deviceId":device.deviceId , "planName" : device.planname , "configs" :
                arrayconfig
            
            ] as [String : Any]
        
        AF.request( url , method: .post , parameters: parameter,encoding: JSONEncoding.default ).responseJSON { (respones) in
            
            
            switch respones.result {
            case .success(_):
                guard let data = respones.data else {
                    return
                }
                let decoder = JSONDecoder()
                print(data)
                if let result = try? decoder.decode(DeviceReponse.self, from: data){
                    print(result)
                    completion(result)
                }
                
            case .failure(_):
                print("fail to reponse ")
            }
//            if respones.result.isSuccess{
//                guard let data = respones.data else {
//                    return
//                }
//                let decoder = JSONDecoder()
//                print(data)
//                if let result = try? decoder.decode(DeviceReponse.self, from: data){
//                    print(result)
//                    completion(result)
//                }
//            }
        }
    }
    
}
