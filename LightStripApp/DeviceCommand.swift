//
//  DeviceCommand.swift
//  LightStripApp
//
//  Created by AXE07 on 11/14/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation

struct DeviceCommand {
    var command: String?
    var ser: String?
    var msgid: String?
    var data: String?
    var key: String?
    
    init(data: String) {
        self.data = data
    }
    
    func convertToDictionary() -> [String: Any] {
        let dic: [String: Any] = ["d" : data!, "cmd": "sn_kx", "key" : "1234567890123456", "msgid" : "1234567890123", "ser": "1234567890"]
        return dic
    }
}
