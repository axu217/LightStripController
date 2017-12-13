//
//  DictionaryProtocol.swift
//  LightStripApp
//
//  Created by AXE07 on 11/27/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

protocol DictionaryConvertible {
    init?(dict:[String:String])
    var dict:[String:String] { get }
}
