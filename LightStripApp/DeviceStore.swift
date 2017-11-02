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
    
    let deviceArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("devices.archive")
    }()
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: deviceArchiveURL.path) as? [Device] {
            allDevices = archivedItems
        } else {
            allDevices = [Device]()
        }
        
    }
    
    func addDevice(newname: String!, newID: String!) {
        allDevices.append(Device(newname: newname, newID: newID))
    }
    
    func saveChanges() -> Bool {
        return NSKeyedArchiver.archiveRootObject(allDevices, toFile: deviceArchiveURL.path)
    }
    
}
