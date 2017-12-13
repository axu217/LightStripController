//
//  FirebaseHelper.swift
//  LightStripApp
//
//  Created by AXE07 on 11/27/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation

class FirebaseHelper {
    
    static var db = AppMeta.AppDelegate.firebaseDB!
    
    static func setHubID(email: String, hubID: String) {
        let ref = db.collection(Constants.users).document(email)
        let data = [Constants.hubID: hubID]
        ref.setData(data)
    }
    
    static func uploadDeviceStore(deviceStore: DeviceStore) {
        let email = UserDefaults.standard.object(forKey: Constants.email) as! String
        let ref = db.collection(Constants.users).document(email).collection("data").document("devices")
        ref.delete()
        for device in deviceStore.allDevices {
            let deviceDict = device.dict as AnyObject
            let data = [device.cloudId: deviceDict]
            ref.setData(data)
        }
        
        if let index = deviceStore.getFavoriteDeviceIndex() {
            ref.setData(["favorite": index])
        } else {
            ref.setData(["favorite": -1])
        }
        
    }

    static func downloadDeviceStore(completionHandler: @escaping (DeviceStore) -> ()) {
        let email = UserDefaults.standard.object(forKey: Constants.email) as! String
        let docRef = db.collection(Constants.users).document(email).collection("data").document("devices")
        let newDeviceStore = DeviceStore()
        
        docRef.getDocument { (document, error) in
            if (document?.exists)!{
                let dict = document!.data()
                for (key, value) in dict {
                    if( key != "favorite") {
                        let deviceDictRep = value as! [String: String]
                        let device = Device(dict: deviceDictRep)
                        newDeviceStore.allDevices.append(device!)
                    } else {
                        if value as! Int != -1 {
                            newDeviceStore.setFavoriteDeviceByIndex(index: value as! Int)
                        } else {
                            newDeviceStore.favoriteDevice = nil
                        }
                    }
                    
                }
                completionHandler(newDeviceStore)
            } else {
                completionHandler(newDeviceStore)
            }
        }
        
        
        
    }
    
    static func getHubIDAndSetDefault(email: String, completion: @escaping () -> () ){
        let docRef = db.collection(Constants.users).document(email)
        
        docRef.getDocument { (document, error) in
            if let document = document {
                let dict = document.data() as! [String: String]
                let uuid = dict[Constants.hubID]!
                UserDefaults.standard.set(uuid, forKey: Constants.uuid)
                UserDefaults.standard.synchronize()
                completion()
            } else {
                print((error! as NSError).localizedDescription)
            }
        }
    }
    
    
    
    
    
}
