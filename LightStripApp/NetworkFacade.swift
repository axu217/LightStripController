//
//  NetworkFacade.swift
//  LightStripApp
//
//  Created by AXE07 on 11/5/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation
import UIKit
import CocoaMQTT

class NetworkFacade {
    
    static var mqtt: CocoaMQTT?
    static let server = "m10.cloudmqtt.com"
    static let username = "hgebmcpm"
    static let password = "5uJEHMv4KHmQ"
    static let port = 12387
    
    static func connect(){
        
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        let newMQTT = CocoaMQTT(clientID: clientID, host: server, port: UInt16(port))
        newMQTT.username = username
        newMQTT.password = password
        newMQTT.keepAlive = 60
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        newMQTT.delegate = appDelegate.mqttdelegate
        newMQTT.connect()
        
        self.mqtt = newMQTT
        
    }
    
    static func publish(message: String) {
        self.mqtt!.publish(AppMeta.uuid + "_cc", withString: message)
        print("published to " + "\(AppMeta.uuid)" + "_cc")
    }
    
    
    //Higher Level Shit That VC calls
    
    static func enterLinkingMode() {
        let cmd: HubCommand = HubCommand(cmd: "e_l", grp: "01", uuid: AppMeta.uuid, ser: "123", msgid: "123", as_c: "1")
        let enterLinkingCommand = HubCommandHelper.createHubCommand(hubCommand: cmd)
        NetworkFacade.publish(message: enterLinkingCommand)
    }
    
    static func checkLinkStatus() {
  
        let cmd: HubCommand = HubCommand(cmd: "g_ls", grp: "01", uuid: AppMeta.uuid, ser: "123", msgid: "123", as_c: "1")
        let checkLinkingCommand = HubCommandHelper.createHubCommand(hubCommand: cmd)
        NetworkFacade.publish(message: checkLinkingCommand)
    }
    
    static func setColor(device: Device, color: UIColor) {
        let red = String(format:"%02x", color.redValue)
        let blue = String(format:"%02x", color.blueValue)
        let green = String(format:"%02x", color.greenValue)
        
        let devID = device.id!
        let toID = devID.subString(startIndex: 4, length: 8)
        let fromID = AppMeta.uuid
        
        
        let packet = LightStripSetPacket(fromID: fromID, toID: toID, mode: "00", data: red + green + blue)
        let hexStr = packet.getHex()
        let devPacket = DeviceCommand(data: hexStr)
        
        NetworkFacade.publishDevicePacket(devPacket: devPacket)
        
    }
    
    static func getStatus(device: Device){
        let devID = device.id!
        let toID = devID.subString(startIndex: 4, length: 8)
        let fromID = AppMeta.uuid
        let packet = LightStripPacket(fromID: fromID, toID: toID, command: "getStatus")
        let hexStr = packet.getHex()
        
        let devPacket = DeviceCommand(data: hexStr)
        NetworkFacade.publishDevicePacket(devPacket: devPacket)
        
    }
    
    static func turnOnOffDevice(device: Device, turnOn: Bool) {
        let devID = device.id!
        let toID = devID.subString(startIndex: 4, length: 8)
        let fromID = AppMeta.uuid
        
        var packet: LightStripSetPacket
        if(turnOn) {
            packet = LightStripSetPacket(fromID: fromID, toID: toID, mode: "00", data: "FF")
        } else {
            packet = LightStripSetPacket(fromID: fromID, toID: toID, mode: "00", data: "")
        }
        
       
        let hexStr = packet.getHex()
        let devPacket = DeviceCommand(data: hexStr)
        
        NetworkFacade.publishDevicePacket(devPacket: devPacket)
    }
    
    static func publishDevicePacket(devPacket: DeviceCommand) {
        
        let deviceCommandArray: [DeviceCommand] = [devPacket]
        let dicArray = (deviceCommandArray.map { $0.convertToDictionary() })[0]
        
        guard let data = try? JSONSerialization.data(withJSONObject: dicArray, options: .prettyPrinted) else {
            print("yo error here in JSONserializing the device packet")
            return
        }
        NetworkFacade.publish(message: String(bytes: data, encoding: .utf8)!)
        
    }
    
    
}
