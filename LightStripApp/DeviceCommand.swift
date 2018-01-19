//
//  DeviceCommand.swift
//  LightStripApp
//
//  Created by AXE07 on 11/14/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation

struct DeviceCommand {
    
    var command: String
    var serialNumber: String = "1234567890"
    var messageID: String = "1234567890123"
    var data: String
    var key: String = "1234567890123456"
    
    static let defaultSerialNumber = "1234567890"
    static let defaultKey = "1234567890123456"
    
    init(data: String) {
        self.command = "sn_kx"
        self.data = data
    }
    
    init(command: String, serialNumber: String, messageID: String, data: String, key: String) {
        self.command = command
        self.serialNumber = serialNumber
        self.messageID = messageID
        self.data = data
        self.key = key
    }
    
    
    func convertToDictionary() -> [String: Any] {
        let dic: [String: Any] = ["d" : data, "cmd": command, "key" : key, "msgid" : messageID, serialNumber: "1234567890"]
        return dic
    }
}
