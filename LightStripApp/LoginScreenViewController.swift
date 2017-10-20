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

class LoginScreenViewController: UIViewController {
    
    
    @IBOutlet var usernameInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    
    @IBAction func login(sender: UIButton) {
        //Pull UUID from server.
        
        let email = usernameInput.text!
        let password = passwordInput.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if (user != nil) {
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(password, forKey: "password")
                UserDefaults.standard.synchronize()
                NetworkHelper.connect()
                
                
                self.performSegue(withIdentifier: "loginSuccess", sender: self)
                

                
            } else {
                let alert = UIAlertController(title: "Registration Failed", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Bruh"), style: .`default`, handler: { _ in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }

        }
    }
    
    @IBAction func register(sender: UIButton) {
        
    }
    
    @IBAction func test(sender: UIButton) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
