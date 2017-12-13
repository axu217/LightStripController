//
//  DeviceStore.swift
//  LightStripApp
//
//  Created by AXE07 on 10/23/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation

class DeviceStore {
    
    var allDevices: [Device]
    var favoriteDevice: Device?
    
    init() {
        allDevices = [Device]()   
    }
    
    func addDevice(newname: String!, newID: String!) {
        allDevices.append(Device(newname: newname, newID: newID))
        
    }
    
    func saveChanges() {
        FirebaseHelper.uploadDeviceStore(deviceStore: self)
    }
    
    func getFavoriteDevice() -> Device?{
        return favoriteDevice
    }
    
    func getFavoriteDeviceIndex() -> Int? {
        if let existingFavorite = favoriteDevice {
            return allDevices.index(of: existingFavorite)
        }
        return nil
    }
    
    func setFavoriteDeviceByIndex(index: Int) {
        favoriteDevice = allDevices[index]
    }
    
    func deleteDevice(_ device: Device) {
        if let index = allDevices.index(of: device) {
            if(allDevices[index] == favoriteDevice) {
                favoriteDevice = nil
            }
            allDevices.remove(at: index)
        }
    }
    
    func count() -> Int {
        return allDevices.count
    }
    
    func getDeviceByIndex(index: Int) -> Device{
        return allDevices[index]
    }
    

    
}
