//
//  MQTTDelegate.swift
//  LightStripApp
//
//  Created by AXE07 on 11/5/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation
import CocoaMQTT

class MQTTDelegate: CocoaMQTTDelegate {
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        
        
        let uuid = UserDefaults.standard.object(forKey: Constants.uuid) as! String
        print(uuid)
        let uuidPost = uuid + "_cc_r"
        mqtt.subscribe(uuidPost, qos: CocoaMQTTQOS.qos2)
        print("did connect ack")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("did publish" )
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("did publish ack")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        print("didReceivedMessage: \(message.string ?? "") with id \(id)")
        let name = NSNotification.Name(rawValue: Constants.message)
        let dict = HubCommandHelper.getJSONResponse(text: message.string!)!
        NotificationCenter.default.post(name: name, object: self, userInfo: [Constants.message: dict, "topic": message.topic])
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        print("did subscribe to \(topic)")
        let name = NSNotification.Name(rawValue: "mqqtSetupDone")
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
}
