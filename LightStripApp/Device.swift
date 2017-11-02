//
//  Device.swift
//  LightStripApp
//
//  Created by AXE07 on 10/23/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation

class Device: NSObject, NSCoding{
    
    var name: String!
    var id: String!
    
    init(newname: String!, newID: String!) {
        name = newname
        id = newID
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        id = aDecoder.decodeObject(forKey: "id") as! String

        
        super.init()
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(id, forKey: "id")
        
    }
    
    
}
