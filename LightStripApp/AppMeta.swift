//
//  AppMeta.swift
//  LightStripApp
//
//  Created by AXE07 on 11/17/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import Foundation
import UIKit

class AppMeta {
    
    static var AppDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    static var uuid: String {
        get {
            return UserDefaults.standard.object(forKey: Constants.uuid) as! String
        }
    }
    
    static func moveToHomeNav() {
        AppMeta.moveTo(location: "HomeNavigation")
    }
    
    static func moveToLogin() {
        AppMeta.moveTo(location: "Login")
    }
    
    static func moveTo(location: String) {
        let window = AppDelegate.window
        
        let storyboard: UIStoryboard = UIStoryboard(name: Constants.storyboard, bundle: Bundle.main)

        if(location == "HomeNavigation") {
            var destination: HomeTabViewController!
            destination = storyboard.instantiateViewController(withIdentifier: Constants.homeNav) as! HomeTabViewController
            window?.rootViewController = destination
            window?.makeKeyAndVisible()
            destination.view.layoutIfNeeded()
            
            UIView.transition(with: window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                window?.rootViewController = destination
            }, completion: nil)
            
        } else {
            var destination: LoginScreenViewController!
            destination = storyboard.instantiateViewController(withIdentifier: Constants.login) as! LoginScreenViewController
            window?.rootViewController = destination
            window?.makeKeyAndVisible()
            destination.view.layoutIfNeeded()
            UIView.transition(with: window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                window?.rootViewController = destination
            }, completion: nil)
            
            
        }

    }
    
}


