//
//  NetworkActual.swift
//  LightStripApp
//
//  Created by Zhe Xu on 2018/01/05.
//  Copyright © 2018 ZheChengXu. All rights reserved.
//

import Foundation
import CocoaMQTT

class NetworkActual {
    
    static var mqtt: CocoaMQTT?
    static let server = "m10.cloudmqtt.com"
    static let username = "hgebmcpm"
    static let password = "5uJEHMv4KHmQ"
    static let port = 12387
    static var completion: (() -> ())?
    
    static func connect(completion: @escaping () -> ()){
        
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        let newMQTT = CocoaMQTT(clientID: clientID, host: server, port: UInt16(port))
        newMQTT.username = username
        newMQTT.password = password
        newMQTT.keepAlive = 300
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        newMQTT.delegate = appDelegate.mqttdelegate
        
        self.completion = completion
        
        let name = NSNotification.Name(rawValue: "mqqtSetupDone")
        NotificationCenter.default.addObserver(self, selector: #selector(NetworkActual.mqttDone(notification:)), name: name, object: nil)
        print("beginConnectMQTT")
        newMQTT.connect()
        print("didConnectMQTT")
        self.mqtt = newMQTT
        
    }
    
    static func disconnect() {
        mqtt?.disconnect()
    }
    
    @objc static func mqttDone(notification: NSNotification) {
        NetworkActual.completion!()
        NotificationCenter.default.removeObserver(self)
    }
    
    static func publish(message: String) {
        self.mqtt!.publish(AppMeta.uuid + "_cc", withString: message)
        print("published to " + "\(AppMeta.uuid)" + "_cc")
    }
    
    
    
    
    static func setDeviceStatus(toID: String, flagByte: String, mode: LightStripSetMode, red: String, blue: String, green: String, speed: String ) {
        
        var hexStr = AppMeta.uuid + toID + flagByte
        //        let devID = device.id!.subString(startIndex: 4, length: 8)
        //        let red = String(format:"%02x", color.redValue)
        //        let blue = String(format:"%02x", color.blueValue)
        //        let green = String(format:"%02x", color.greenValue)
        
        switch mode {
        case .solid:
            hexStr = hexStr + "00" + red + green + blue
        case .dynamic:
            hexStr = hexStr + "01" + speed
        case .gradient:
            hexStr = hexStr + "02" + speed
        }
        
        hexStr = hexStr.padding(toLength: 48, withPad: "0", startingAt: 0)
        let devPacket = DeviceCommand(data: hexStr)
        NetworkActual.publishDevicePacket(devPacket: devPacket)
        
    }
    
    
    static func getDeviceStatus(toID: String, messageID: String){
        var hexStr = AppMeta.uuid + toID + "00" + "0017"
        hexStr = hexStr.padding(toLength: 48, withPad: "0", startingAt: 0)
        let deviceCommand = DeviceCommand(command: "sn_kx", serialNumber: DeviceCommand.defaultSerialNumber, messageID: messageID, data: hexStr, key: DeviceCommand.defaultKey)
        NetworkActual.publishDevicePacket(devPacket: deviceCommand)
        
    }
    
    static func setDeviceSchedule(toID: String, index: String, weekMask: String, zoneMask: String, onHour: String, onMinute: String, offHour: String, offMinute: String, red: String, green: String, blue: String, mode: String, speed: String) {
        
        var hexStr = AppMeta.uuid + toID + "00" + "0023"
        
        hexStr = hexStr + index + weekMask + zoneMask + onHour + onMinute + offHour + offMinute + red + green + blue + mode + speed
        
        hexStr = hexStr.padding(toLength: 48, withPad: "0", startingAt: 0)
        let devPacket = DeviceCommand(data: hexStr)
        NetworkActual.publishDevicePacket(devPacket: devPacket)
    }
    
    static func getDeviceSchedule(toID: String, messageID: String) {
        var hexStr = AppMeta.uuid + toID + "00" + "0022" + "01"
        hexStr = hexStr.padding(toLength: 48, withPad: "0", startingAt: 0)
        let deviceCommand = DeviceCommand(command: "sn_kx", serialNumber: DeviceCommand.defaultSerialNumber, messageID: messageID, data: hexStr, key: DeviceCommand.defaultKey)
        NetworkActual.publishDevicePacket(devPacket: deviceCommand)
    }
    
    static func enterLinkingMode() {
        let cmd: HubCommand = HubCommand(cmd: "e_l", grp: "01", uuid: AppMeta.uuid, ser: "123", msgid: "123", as_c: "1")
        let dicArray = cmd.convertToDictionary()
        
        guard let data = try? JSONSerialization.data(withJSONObject: dicArray, options: .prettyPrinted) else {
            print("ERROR")
            return
        }
        
        let enterLinkingCommand = String(bytes: data, encoding: .utf8)!
        
        NetworkActual.publish(message: enterLinkingCommand)
    }
    
    static func checkLinkingStatus() {
        let cmd: HubCommand = HubCommand(cmd: "g_ls", grp: "01", uuid: AppMeta.uuid, ser: "123", msgid: "123", as_c: "1")
        let dicArray = cmd.convertToDictionary()
        
        
        guard let data = try? JSONSerialization.data(withJSONObject: dicArray, options: .prettyPrinted) else {
            print("ERROR")
            return
        }
        
        let checkLinkingCommand = String(bytes: data, encoding: .utf8)!
        NetworkActual.publish(message: checkLinkingCommand)
    }
    
    
    
    
    
    static func publishDevicePacket(devPacket: DeviceCommand) {
        
        let deviceCommandArray: [DeviceCommand] = [devPacket]
        let dicArray = (deviceCommandArray.map { $0.convertToDictionary() })[0]
        
        guard let data = try? JSONSerialization.data(withJSONObject: dicArray, options: .prettyPrinted) else {
            print("yo error here in JSONserializing the device packet")
            return
        }
        NetworkActual.publish(message: String(bytes: data, encoding: .utf8)!)
        
    }
    
}
