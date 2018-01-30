//
//  NetworkBridge.swift
//  LightStripApp
//
//  Created by Zhe Xu on 2018/01/06.
//  Copyright © 2018 ZheChengXu. All rights reserved.
//

import Foundation
import UIKit


class NetworkBridge {
    
    static func getDeviceSchedule(device: Device, completion: @escaping ([Bool], String, String, String, String) -> ()) {
        let messageID = IDGenerator.getID()
        NetworkActual.getDeviceSchedule(toID: device.id.subString(startIndex: 4, length: 8), messageID: messageID)
        
        let name = NSNotification.Name(rawValue: Constants.message)
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil) { notification in
            let userInfo = notification.userInfo as! [String: AnyObject]
            let dict = userInfo[Constants.message] as! [String: String]
            
            //handle error case
            if(dict["msgid"] == messageID) {
                guard let data = dict["d"] else {
                    print("DANG WE FKED CUS NO DATA")
                    return
                }
                var weekMask = data.subString(startIndex: 13*2, length: 2)
                weekMask = String(Int(weekMask, radix: 16)!, radix: 2)
                var weekBoolArray: [Bool] = []
                
                for (index, char) in weekMask.enumerated() {
                    if index <= 6 {
                        if(char == "1") {
                            weekBoolArray[index] = true
                        } else {
                            weekBoolArray[index] = false
                        }
                    }
                }
                //hex string to binary
                let onHour = data.subString(startIndex: 15*2, length: 2)
                let onMinute = data.subString(startIndex: 16*2, length: 2)
                let offHour = data.subString(startIndex: 17*2, length: 2)
                let offMinute = data.subString(startIndex: 18*2, length: 2)
                
                completion(weekBoolArray, onHour, onMinute, offHour, offMinute)
                
            }
            
        }
        
    }
    
    static func getDeviceStatus(device: Device, completion: @escaping (Bool, LightStripSetMode, UIColor, Int) -> ()) {
        let messageID = IDGenerator.getID()
        NetworkActual.getDeviceStatus(toID: device.id.subString(startIndex: 4, length: 8), messageID: messageID)
        let name = NSNotification.Name(rawValue: Constants.message)
        
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil) { notification in
            let userInfo = notification.userInfo as! [String: AnyObject]
            let dict = userInfo[Constants.message] as! [String: String]
            
            //handle error case 
            if(dict["msgid"] == messageID) {
                guard let data = dict["d"] else {
                    print("DANG WE FKED CUS NO DATA")
                    return
                }
                
                let modeByte = data.subString(startIndex: 13*2, length: 2)
                let data3 = data.subString(startIndex: 14 * 2, length: 2)
                let data4 = data.subString(startIndex: 15 * 2, length: 2)
                let data5 = data.subString(startIndex: 16 * 2, length: 2)
                let data6 = data.subString(startIndex: 17 * 2, length: 2)

                var mode: LightStripSetMode = .solid
                var color: UIColor?
                var speed: Int?
                
                if modeByte == "00" {
                    mode = .solid
                    let redColor = Int(data3, radix: 16)!
                    let greenColor = Int(data4, radix: 16)!
                    let blueColor = Int(data5, radix: 16)!
                    color = UIColor(red: CGFloat(redColor), green: CGFloat(greenColor), blue: CGFloat(blueColor), alpha: 1.0)
                    speed = 1
                    
                } else if modeByte == "01" {
                    mode = .dynamic
                    let redColor = Int(data4, radix: 16)!
                    let greenColor = Int(data5, radix: 16)!
                    let blueColor = Int(data6, radix: 16)!
                    color = UIColor(red: CGFloat(redColor), green: CGFloat(greenColor), blue: CGFloat(blueColor), alpha: 1.0)
                    speed = Int(data3, radix: 16)! //idk what this format is supposed to be
                } else {
                    mode = .gradient
                    let redColor = Int(data4, radix: 16)!
                    let greenColor = Int(data5, radix: 16)!
                    let blueColor = Int(data6, radix: 16)!
                    color = UIColor(red: CGFloat(redColor), green: CGFloat(greenColor), blue: CGFloat(blueColor), alpha: 1.0)
                    speed = Int(data3, radix: 16)!
                }
                
                completion(true, mode, color!, speed!)
                
            }
            
        }
        
    }
    
    static func setDeviceStatus(device: Device, mode: LightStripSetMode, color: UIColor, speed: Int, completion: @escaping (Bool) -> () ) {
        let messageID = IDGenerator.getID()
        let toID = device.id.subString(startIndex: 4, length: 8)
        let red = String(format:"%02x", color.redValue)
        let blue = String(format:"%02x", color.blueValue)
        let green = String(format:"%02x", color.greenValue)
        
        
        NetworkActual.setDeviceStatus(toID: toID, flagByte: "00", mode: mode, red: red, blue: blue, green: green, speed: "\(speed)")
        let name = NSNotification.Name(rawValue: Constants.message)
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil) { notification in
            let userInfo = notification.userInfo as! [String: AnyObject]
            let dict = userInfo[Constants.message] as! [String: String]
            
            //handle error case
            if(dict["msgid"] == messageID) {
                guard let data = dict["d"] else {
                    print("DANG WE FKED CUS NO DATA")
                    return
                }
                print(data)
                //if all good
                completion(true)
                
            }
            
        }
    }
    
    
    /*
    static func setDeviceSchedule(device: Device, weekDays: [Bool], startTime: ) {
    
    }*/
}


