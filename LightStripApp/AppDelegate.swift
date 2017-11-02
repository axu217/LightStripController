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
class AppDelegate: UIResponder, UIApplicationDelegate, CocoaMQTTDelegate {
    
    

    var window: UIWindow?
    var firebaseDB: Firestore?
    var deviceStore: DeviceStore = DeviceStore()
    var colorStore: ColorStore = ColorStore()
    var favoriteStore: FavoriteStore = FavoriteStore()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        self.firebaseDB = Firestore.firestore()
  
        
        let hasLoggedIn: Bool? = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if (hasLoggedIn == true) {

            
            let email = UserDefaults.standard.object(forKey: "email") as! String
            let password = UserDefaults.standard.object(forKey: "password") as! String
            let uuidAny = UserDefaults.standard.object(forKey: "uuid")
            if uuidAny == nil {
                let docRef = firebaseDB?.collection("users").document(email)
                docRef?.getDocument { (document, error) in
                    if let document = document {
                        let dict = document.data() as! [String: String]
                        let uuid = dict["hubID"]
                        UserDefaults.standard.set(uuid, forKey: "uuid")
                    } else {
                        
                    }
                }
            }
 
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if user != nil {
                    
                    NetworkHelper.connectWithDelegate(delegate: self)
                    
                    
    
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let navigationController: HomeNavigationController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as! HomeNavigationController
                    self.window!.makeKeyAndVisible()
                    navigationController.view.layoutIfNeeded()
                    UIView.transition(with: self.window!, duration: 0.2, options: .transitionCrossDissolve, animations: {
                        self.window!.rootViewController = navigationController
                        
                    }, completion: nil)
                    
                    
                    
                    
                } else {
                    print((error! as NSError).localizedDescription)
                }
            }
            
            
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let logInViewController: LoginScreenViewController = storyboard.instantiateViewController(withIdentifier: "LoginScreenViewController") as! LoginScreenViewController
            self.window!.makeKeyAndVisible()
            logInViewController.view.layoutIfNeeded()
            UIView.transition(with: self.window!, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.window!.rootViewController = logInViewController
                
            }, completion: nil)
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        let _ = deviceStore.saveChanges()
        colorStore.saveChanges()
        favoriteStore.saveChanges()

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        let uuid = UserDefaults.standard.object(forKey: "uuid") as! String
        let uuidPost = uuid + "_cc_r"
        mqtt.subscribe(uuidPost)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        
    }


}

