//
//  DeviceStore.swift
//  LightStripApp
//
//  Created by AXE07 on 10/23/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation

class FavoriteStore {
    
    var favoriteDevices: [Device]
    
    let favoriteArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("favorites.archive")
    }()
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: favoriteArchiveURL.path) as? [Device] {
            favoriteDevices = archivedItems
        } else {
            favoriteDevices = [Device]()
        }
        
    }
    
    func addFavorite(device: Device) {
        favoriteDevices.append(device)
    }
    
    func saveChanges() {
        NSKeyedArchiver.archiveRootObject(favoriteDevices, toFile: favoriteArchiveURL.path)
    }
    
}

