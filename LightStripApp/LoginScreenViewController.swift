//
//  LoginScreenViewController.swift
//  LightStripController
//
//  Created by AXE07 on 10/10/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit
import Firebase
import CocoaMQTT

class LoginScreenViewController: UIViewController, UITextFieldDelegate {
    
    var waitingAlert: UIAlertController?
    
    @IBOutlet var usernameInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    
    @IBAction func login(sender: UIButton) {
        //Pull UUID from server.
        usernameInput.resignFirstResponder()
        passwordInput.resignFirstResponder()
        waitingAlert = UIAlertController.createAlertAndPresent(viewController: self, title: "Logging In", message: "Connecting to the Server")
        
        let email = usernameInput.text!
        let password = passwordInput.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if user != nil {
                
                UserDefaults.standard.set(true, forKey: Constants.isUserLoggedIn)
                UserDefaults.standard.set(email, forKey: Constants.email)
                UserDefaults.standard.set(password, forKey: Constants.password)
                UserDefaults.standard.synchronize()
                
                let group = DispatchGroup()
                
                group.enter()
                
                FirebaseHelper.getHubIDAndSetDefault(email: email, completion: {
                    NetworkFacade.connect() {
                        group.leave()
                    }
                })
                

                group.enter()
                FirebaseHelper.downloadDeviceStore() { deviceStore in
                    AppMeta.AppDelegate.deviceStore = deviceStore
                    group.leave()
                }
                
                group.notify(queue: .main) {
                    self.performSegue(withIdentifier: "loginToHome", sender: self)
                }
                
            } else {
                let errorText = error!.localizedDescription
                self.waitingAlert?.dismiss(animated: true, completion: nil)
                
                let alert = UIAlertController.createAlertAndPresent(viewController: self, title: "Login Failed", message: errorText)
                
                alert.customAddAction(title: "Dismiss") {
                    alert.dismiss(animated: true, completion: nil)
                }
            }

        }
        
    }
    
    @IBAction func register(sender: UIButton) {
        passwordInput.resignFirstResponder()
        self.performSegue(withIdentifier: Constants.loginToRegister, sender: self)
    }
    


    // MARK: View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        passwordInput.delegate = self
        view.backgroundColor = UIColor(rgb: 0xE8ECEE)
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        super.viewWillDisappear(animated)
    }
}
