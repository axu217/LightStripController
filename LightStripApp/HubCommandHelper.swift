//
//  HubCommandHelper.swift
//  LightStripApp
//
//  Created by AXE07 on 10/23/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation

class HubCommandHelper {
    
    static func createHubCommand(hubCommand: HubCommand) -> String {
        var hubCommandArray = [HubCommand]()
        hubCommandArray.append(hubCommand)
        let dicArray = (hubCommandArray.map { $0.convertToDictionary() })[0]
        
        if let data = try? JSONSerialization.data(withJSONObject: dicArray, options: .prettyPrinted) {
            let str = String(bytes: data, encoding: .utf8)
            return str!
        }
        
        return "error"
        
        
    }
    
    static func getJSONResponse(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
        
    }
}

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


