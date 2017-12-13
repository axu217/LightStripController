//
//  HubCommandHelper.swift
//  LightStripApp
//
//  Created by AXE07 on 10/23/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation
import UIKit



class HubCommandHelper {
    
    static func createHubCommand(hubCommand: HubCommand) -> String {
        var hubCommandArray = [HubCommand]()
        hubCommandArray.append(hubCommand)
        let dicArray = (hubCommandArray.map { $0.convertToDictionary() })[0]
        
        if let data = try? JSONSerialization.data(withJSONObject: dicArray, options: .prettyPrinted) {
            let str = String(bytes: data, encoding: .utf8)
            return str!
        }
        
        return "error"
        
    }
    
    static func getJSONResponse(text: String) -> [String: String]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
        
    }
    

}









