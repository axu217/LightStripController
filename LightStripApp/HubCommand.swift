//
//  HubCommand.swift
//  LightStripApp
//
//  Created by AXE07 on 11/14/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation

struct HubCommand {
    var cmd: String
    var grp: String
    var uuid: String
    var ser: String
    var msgid: String
    var as_c: String
    
    init(cmd: String, grp: String, uuid: String, ser: String, msgid: String, as_c: String) {
        self.cmd = cmd
        self.grp = grp
        self.uuid = uuid
        self.ser = ser
        self.msgid = msgid
        self.as_c = as_c
    }
    
    func convertToDictionary() -> [String: Any] {
        let dic: [String: Any] = ["cmd": cmd, "grp": grp, "uuid" : uuid, "ser": ser, "msgid": msgid, "as_c": as_c]
        return dic
    }
    
}
