//
//  String.swift
//  LightStripApp
//
//  Created by AXE07 on 11/4/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation

extension String {
    
    func subString(startIndex: Int, length: Int) -> String
    {
        let begin = self.index(self.startIndex, offsetBy: startIndex)
        let end = self.index(self.startIndex, offsetBy: startIndex + length - 1)
        return String(self[begin...end])
    }
    
    func toHexByteString() -> String {
        let length: Int = self.count
        let bytes: Int = (length/2) - 1
        var returnString: String = ""
        
        for i in 0...bytes {
            let sub = subString(startIndex: i * 2, length: 2)
            let intSub = Int(sub)
            let hexStr = String(format:"%02X", intSub!)
            returnString = returnString + hexStr
        }
        return returnString
    }
}
