//
//  Constants.swift
//  LightStripApp
//
//  Created by AXE07 on 11/30/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation

class Constants {
    
    // MARK: - NotificationCenter
    
    static let message = "MQTTMessageNotification"
    static let subscribeAck = "SubscribeAck"
    static let response = "response"
    
    // MARK: - Reuse Identifiers
    
    static let colorCollectionCell = "colorCell"
    static let deviceTableCell = "DeviceCell"
    static let selectFavoriteCell = "AddFavoriteCell"
    static let favoriteCollectionCell = "favoriteColorCell"

    // MARK: - Segue Identifiers
    
    static let deviceToAddDevice = "addDevice"
    static let deviceToControlDevice = "controlDevice"
    
    static let loginToRegister = "register"
    static let colorToAddColor = "AddColor"
    
    static let favoriteToSelectFavorite = "addFavorite"
    
    // MARK: - UserDefault Keys
    
    static let isUserLoggedIn = "isUserLoggedIn"
    static let email = "email"
    static let password = "password"
    static let uuid = "uuid"
    
    //static let favoriteDeviceIndex = "favoriteDeviceIndex"
    
    // MARK: - Firebase
    
    static let users = "users"
    static let hubID = "hubID"
    
    // MARK: - View Controller Identifiers
    
    static let homeNav = "HomeNavigationController"
    static let login = "LoginScreenViewController"
    static let storyboard = "Main"
    
    // MARK: - YoSmart
    
    static let linkStatus = "link_status"
    static let id = "id"
    static let status = "status"
}

