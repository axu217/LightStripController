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
    
    static var mqttSession: MQTTSession? = nil
    
    static func connectWithDelegate(delegate: CocoaMQTTDelegate){
        let mqttSession = MQTTSession()
        
        self.mqttSession = mqttSession
        
        mqttSession.mqtt.delegate = delegate
        mqttSession.mqtt.connect()
    }
    
    static func publish(message: String) {
        let uuid = UserDefaults.standard.object(forKey: "uuid") as! String
        

        self.mqttSession!.mqtt.publish(uuid + "_cc", withString: message)
    }
   
    
}
