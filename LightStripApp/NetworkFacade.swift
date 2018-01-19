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
    
    static func connect(completion: @escaping () -> ()){
        NetworkActual.connect(completion: completion)
    }
    
    static func disconnect() {
        NetworkActual.disconnect()
    }
    
    static func enterLinkingMode() {
        NetworkActual.enterLinkingMode()
    }
    
    static func checkLinkingStatus() {
        NetworkActual.checkLinkingStatus()
    }
    
    
    static var getWeekDayScheduleClosure: (([Bool]) -> ())? = nil
    static var getDeviceStartTimeClosure: ((String) -> ())? = nil
    static var getDeviceEndTimeClosure: ((String) -> ())? = nil
    
    
    static var getDeviceConnectionStatusClosure: ((Bool) -> ())? = nil
    static var getDeviceModeClosure: ((LightStripSetMode) -> ())? = nil
    static var getDeviceColorClosure: ((UIColor) -> ())? = nil
    static var getDeviceSpeedClosure: ((Int) -> ())? = nil

    
    
    static func getDeviceConnectionStatus(completion: @escaping (Bool) -> ()){
        NetworkFacade.getDeviceConnectionStatusClosure = completion
    }
    
    static func getDeviceMode(completion: @escaping (LightStripSetMode) -> ()){
        NetworkFacade.getDeviceModeClosure = completion
    }
    
    static func getDeviceColor(completion: @escaping (UIColor) -> ()) {
        NetworkFacade.getDeviceColorClosure = completion
    }
    
    static func getDeviceSpeed(completion: @escaping (Int) -> ()) {
        NetworkFacade.getDeviceSpeedClosure = completion
    }
    static func getStatusActual(device: Device) {
        
        DispatchQueue.global().async {
            NetworkBridge.getDeviceStatus(device: device) {isConnected, lightMode, color, speed in
                guard let getDeviceConnectionStatusClosure = NetworkFacade.getDeviceConnectionStatusClosure else { return }
                guard let getDeviceModeClosure = NetworkFacade.getDeviceModeClosure else { return }

                DispatchQueue.main.async {
                    getDeviceConnectionStatusClosure(isConnected)
                    if(isConnected) {
                        getDeviceModeClosure(lightMode)
                    }
                }
            }
        }
    }
    
    static func getDeviceWeekdaySchedule(completion: @escaping ([Bool]) -> ()) {
        NetworkFacade.getWeekDayScheduleClosure = completion
    }
    
    static func getDeviceStartTime(completion: @escaping (String) -> ()){
        NetworkFacade.getDeviceStartTimeClosure = completion
    }
    
    static func getDeviceEndTime(completion: @escaping (String) -> ()) {
        NetworkFacade.getDeviceEndTimeClosure = completion
    }
    
    //Key Method
    static func getScheduleActual(device: Device) {
        
        DispatchQueue.global().async {
            NetworkBridge.getDeviceSchedule(device: device) {boolArray, onHour, onMinute, offHour, offMinute in
                guard let getWeekDayScheduleClosure = NetworkFacade.getWeekDayScheduleClosure else { return }
                guard let getDeviceStartTimeClosure = NetworkFacade.getDeviceStartTimeClosure else { return }
                guard let getDeviceEndTimeClosure = NetworkFacade.getDeviceEndTimeClosure else { return }
                
                DispatchQueue.main.async {
                    getWeekDayScheduleClosure(boolArray)
                    getDeviceStartTimeClosure(onHour + ":" + onMinute)
                    getDeviceEndTimeClosure(offHour + ":" + offMinute)
                }
            }
        }
        
    }
    
    
}
