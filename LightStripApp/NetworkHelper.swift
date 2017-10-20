//
//  NetworkHelper.swift
//  LightStripController
//
//  Created by AXE07 on 10/2/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation
import CocoaMQTT

class NetworkHelper {
    
    static var isConnected: Bool = false
    static var mqtt: MQTTSession? = nil
    
    static func connect(){
        let mqtt = MQTTSession()
        self.mqtt = mqtt
    }
    
    static func send(message: String) {
        
    }
    
}
