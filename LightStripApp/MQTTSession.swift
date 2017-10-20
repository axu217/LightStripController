//
//  MQTTSession.swift
//  LightStripApp
//
//  Created by AXE07 on 10/18/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation
import CocoaMQTT

class MQTTSession {
    
    let server = "m10.cloudmqtt.com"
    let username = "hgebmcpm"
    let password = "5uJEHMv4KHmQ"
    let port = 12387
    
    var mqtt: CocoaMQTT
    
    init() {
        let delegate = MQTTDelegate()
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        let mqtt = CocoaMQTT(clientID: clientID, host: server, port: UInt16(port))
        mqtt.username = username
        mqtt.password = password
        mqtt.keepAlive = 60
        mqtt.delegate = delegate
        mqtt.connect()
        self.mqtt = mqtt
    }
    
    
}
