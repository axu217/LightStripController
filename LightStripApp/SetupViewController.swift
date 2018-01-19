//
//  SetupViewController.swift
//  LightStripApp
//
//  Created by AXE07 on 12/1/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SetupViewController: UIViewController {
    

    override func viewDidLoad() {
        
        view.setGradient(colorOne: UIColor(rgb: 0x4A90E2), colorTwo: UIColor(rgb: 0x54CBE6))
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let hasLoggedIn: Bool? = UserDefaults.standard.bool(forKey: Constants.isUserLoggedIn)
        if (hasLoggedIn == true) {
            
            SVProgressHUD.show(withStatus: "Loading")
            let email = UserDefaults.standard.object(forKey: Constants.email) as! String
            let password = UserDefaults.standard.object(forKey: Constants.password) as! String
            
            let group = DispatchGroup()
            group.enter()
            FirebaseHelper.getHubIDAndSetDefault(email: email) {
                print("GOT HUB ID")
                NetworkFacade.connect() {
                    print("CONNECTED MQTT ")
                    group.leave()
                }
            }
            
            group.enter()
            FirebaseHelper.downloadDeviceStore() {newStore in
                AppMeta.AppDelegate.deviceStore = newStore
                print("got store")
                group.leave()
            }
            
            group.enter()
            Auth.auth().signIn(withEmail: email, password: password) {
                (user, error) in
                print("signed in")
                group.leave()
            }

            group.notify(queue: .main) {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "setupToHome", sender: nil)
            }
 
        } else {
            self.performSegue(withIdentifier: "setupToLoginYo", sender: nil)
        }
    }
    

}
