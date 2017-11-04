//
//  MQTTDelegate.swift
//  LightStripApp
//
//  Created by AXE07 on 10/18/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import CocoaMQTT

class MQTTDelegate: CocoaMQTTDelegate {
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        
        let uuid = UserDefaults.standard.object(forKey: "uuid") as! String
        let uuidPost = uuid + "_cc_r"
        mqtt.subscribe(uuidPost, qos: CocoaMQTTQOS.qos2)
        print("did connect ack")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("did publish")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("did publish ack")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        print("didReceivedMessage: \(message.string ?? "") with id \(id)")
        let name = NSNotification.Name(rawValue: "MQTTMessageNotification")
        NotificationCenter.default.post(name: name, object: self, userInfo: ["message": message.string!, "topic": message.topic])
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        let name = NSNotification.Name(rawValue: "subscribeAck")
        NotificationCenter.default.post(name: name, object: self)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print("did unsubscribe")
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("did ping")
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print("did receive ping")
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("did disconnect")
    }
    
    init() {
        
    }
}
