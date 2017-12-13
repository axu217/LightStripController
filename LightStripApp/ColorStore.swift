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
            allColors.append(UIColor.green)
            allColors.append(UIColor.red)
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
