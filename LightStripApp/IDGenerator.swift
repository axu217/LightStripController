//
//  IDGenerator.swift
//  LightStripApp
//
//  Created by Zhe Xu on 2018/01/08.
//  Copyright © 2018 ZheChengXu. All rights reserved.
//

import Foundation

class IDGenerator {
    
    static var count: Int = 0
    
    static func getID() -> String{
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 13
        
        guard let returnStr = formatter.string(from: NSNumber(value: count)) else {
            print(" YOU FKED UP HERE BIG TIME")
            return "lmaoyouFked"
        }
        
        return returnStr
    }
}
