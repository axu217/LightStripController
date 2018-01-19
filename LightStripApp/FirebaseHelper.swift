//
//  FirebaseHelper.swift
//  LightStripApp
//
//  Created by AXE07 on 11/27/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation
import Firebase

class FirebaseHelper {
    
    static var db = AppMeta.AppDelegate.firebaseDB!
    
    static func setHubID(email: String, hubID: String, completion: @escaping () -> ()) {
        let ref = db.collection(Constants.users).document(email)
        let data = [Constants.hubID: hubID]
        ref.setData(data, options: SetOptions.merge()) { (error) in
            if(error == nil) {
                completion()
            }
        }
    }
    
    static func uploadDeviceStore(deviceStore: DeviceStore) {
        let email = UserDefaults.standard.object(forKey: Constants.email) as! String
        let ref = db.collection(Constants.users).document(email).collection("devices")
        
        
        for device in deviceStore.allDevices {
//case when two devices are named same. get rid of it.
            ref.document(device.name).setData(device.dict)
        }
        
        let favRef = db.collection(Constants.users).document(email).collection("devices").document("favorite")
        var data: [String: Any] = [:]
        if let index = deviceStore.getFavoriteDeviceIndex() {
            data["favorite"] = index
            
        } else {
            data["favorite"] = -1
        }
        favRef.setData(data)
        
    }

    static func downloadDeviceStore(completionHandler: @escaping (DeviceStore) -> ()) {
        let email = UserDefaults.standard.object(forKey: Constants.email) as! String
        let devicesRef = db.collection(Constants.users).document(email).collection("devices")
        let newDeviceStore = DeviceStore()
        
        devicesRef.getDocuments { (snapshot, error) in
            if let unwrappedSnapShot = snapshot {
                for document in unwrappedSnapShot.documents {
                    if document.documentID != "favorite" {
                        let data = document.data()
                        let deviceDictRep = data as! [String: String]
                        let device = Device(dict: deviceDictRep)
                        newDeviceStore.allDevices.append(device!)
                    }
                }
            } else {
                print(error?.localizedDescription ?? "error in reading data")
            }
        }
        
        let favRef = db.collection(Constants.users).document(email).collection("devices").document("favorite")
        
        favRef.getDocument() { document, error in
            
            if let documentExist = document{
                let data = documentExist.data()
                let value = data["favorite"] as! Int
                if(value != -1) {
                    newDeviceStore.setFavoriteDeviceByIndex(index: value)
                }
            } else {
                print(error?.localizedDescription ?? "error in reading data")
            }
        }
        
        completionHandler(newDeviceStore)
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
