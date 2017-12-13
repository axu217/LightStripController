//
//  LightStripSetPacket.swift
//  LightStripApp
//
//  Created by AXE07 on 11/14/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation

class LightStripPacket {
    
    var fromID: String
    var toID: String
    var command: String
    var data: String?
    
    init(fromID : String, toID: String, command: String) {
        self.fromID = fromID
        self.toID = toID
        self.command = command
    }
    
    func getHex() -> String {
        var toReturn = ""
        toReturn = toReturn + toID
        toReturn = toReturn + "00"
        
        if (command == "set") {
            toReturn = toReturn + "003A"
        } else if (command == "getStatus") {
            toReturn = toReturn + "0017"
        }else {
            return "ERROR"
        }
        
        if data != nil {
            toReturn = toReturn + data!
        }
        
        return toReturn.padding(toLength: 48, withPad: "0", startingAt: 0)
    }
    
}

class LightStripSetPacket: LightStripPacket {
    
    init(fromID: String, toID: String, mode: String, data: String) {
        super.init(fromID: fromID, toID: toID, command: "set")
        var bigData = mode
        bigData = bigData + "FF" + data
        self.data = bigData
    }
    
}
