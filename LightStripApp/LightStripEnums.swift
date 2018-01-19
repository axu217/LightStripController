//
//  LightStripSetPacket.swift
//  LightStripApp
//
//  Created by AXE07 on 11/14/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation

enum LightStripCommandType {
    case setDeviceStatus
    case getDeviceStatus
    case setSleepMinutes
    case setWakeMinutes
    case getDeviceSchedule
    case setDeviceSchedule
}

enum LightStripSetMode {
    case gradient
    case solid
    case dynamic
}


