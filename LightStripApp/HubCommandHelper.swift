//
//  HubCommandHelper.swift
//  LightStripApp
//
//  Created by AXE07 on 10/23/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation
import UIKit

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
    
    static func getJSONResponse(text: String) -> [String: String]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
        
    }
    
    static func createSingleColorCommand(device: Device, color: UIColor) -> String{
        let red = String(format:"%02x", color.redValue)
        let blue = String(format:"%02x", color.blueValue)
        let green = String(format:"%02x", color.greenValue)
        
        let devID = device.id!
        let toID = devID.subString(startIndex: 4, length: 8)
        let fromID = UserDefaults.standard.object(forKey: "uuid") as! String
        
  
        let packet = LightStripSetPacket(fromID: fromID, toID: toID, mode: "00", data: red + green + blue)
        let hexStr = packet.getHex()
        let devPacket = DeviceCommand(data: hexStr)
        
        var deviceCommandArray = [DeviceCommand]()
        deviceCommandArray.append(devPacket)
        let dicArray = (deviceCommandArray.map { $0.convertToDictionary() })[0]
        
        if let data = try? JSONSerialization.data(withJSONObject: dicArray, options: .prettyPrinted) {
            let str = String(bytes: data, encoding: .utf8)
            return str!
        }
        return ""
        
        
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

struct DeviceCommand {
    var command: String?
    var ser: String?
    var msgid: String?
    var d: String
    var key: String?
    
    init(data: String) {
        self.d = data
    }
    
    func convertToDictionary() -> [String: Any] {
        let dic: [String: Any] = ["d" : d, "cmd": "sn_kx", "key" : "1234567890123456", "msgid" : "1234567890123", "ser": "1234567890"]
        return dic
    }
}

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
        } else {
            return "ERROR"
        }
        toReturn = toReturn + data!
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


