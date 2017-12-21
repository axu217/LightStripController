//
//  ColorStore.swift
//  LightStripApp
//
//  Created by AXE07 on 10/30/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit

class ColorStore {
    
    var allColors: [UIColor]
    
    let colorArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("colorss.archive")
    }()
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: colorArchiveURL.path) as? [UIColor] {
            allColors = archivedItems
        } else {
            allColors = [UIColor]()
            allColors.append(UIColor(rgb: 0xF5A623))
            allColors.append(UIColor(rgb: 0xD0021B))
            allColors.append(UIColor(rgb: 0xF8E71C))
            allColors.append(UIColor(rgb: 0x8B572A))
            
            allColors.append(UIColor(rgb: 0x7ED321))
            allColors.append(UIColor(rgb: 0x417505))
            allColors.append(UIColor(rgb: 0xBD10E0))
            allColors.append(UIColor(rgb: 0x9013FE))
            
            allColors.append(UIColor(rgb: 0x4A90E2))
            allColors.append(UIColor(rgb: 0x50E3C2))
            allColors.append(UIColor(rgb: 0xB8E986))
        }
        
    }
    
    func addColor(color: UIColor) {
        allColors.append(color)
    }
    
    func removeColorByIndex(index: Int) {
        allColors.remove(at: index)
    }
    
    
    func saveChanges() {
        NSKeyedArchiver.archiveRootObject(allColors, toFile: colorArchiveURL.path)
    }
    
    func count() -> Int {
        return allColors.count
    }
    
    func getColorByIndex(index: Int) -> UIColor{
        return allColors[index]
    }
    
    
}
