//
//  Device.swift
//  LightStripApp
//
//  Created by AXE07 on 10/23/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation

class Device: NSObject, DictionaryConvertible{
    
    var name: String!
    var cloudId: String!
    static var cloudIDCounter: Int! = 0
    var id: String!
    
    init(newname: String!, newID: String!) {
        name = newname
        cloudId = "\(Device.cloudIDCounter)"
        Device.cloudIDCounter = Device.cloudIDCounter + 1
        id = newID
        super.init()
    }

    
    required convenience init?(dict: [String: String]) {
        guard let name = dict["name"], let id = dict["id"] else {
            return nil
        }
        self.init(newname: name, newID: id)
    }
    
    var dict:[String : String] {
        return [
            "name": name,
            "id": id
        ]
    }
    
    
}
