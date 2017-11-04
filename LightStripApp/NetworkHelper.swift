//
//  NetworkHelper.swift
//  LightStripController
//
//  Created by AXE07 on 10/2/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation
import CocoaMQTT
import Firebase

class NetworkHelper {
    
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
        newMQTT.delegate = MQTTDelegate()
        newMQTT.connect()
        self.mqtt = newMQTT
        
    }
    
    static func publish(message: String) {
        let uuid = UserDefaults.standard.object(forKey: "uuid") as! String
        self.mqtt!.publish(uuid + "_cc", withString: message)
    }
    
   
    
}
