//
//  AppDelegate.swift
//  LightStripController
//
//  Created by AXE07 on 10/2/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit
import Firebase
import CocoaMQTT

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var firebaseDB: Firestore?
    var deviceStore: DeviceStore = DeviceStore()
    var colorStore: ColorStore = ColorStore()
    var mqttdelegate: MQTTDelegate = MQTTDelegate()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        self.firebaseDB = Firestore.firestore()

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        deviceStore.saveChanges()
        colorStore.saveChanges()
        NetworkFacade.disconnect()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
 
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }

}


