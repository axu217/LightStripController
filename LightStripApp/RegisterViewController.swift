//
//  RegisterViewController.swift
//  LightStripController
//
//  Created by AXE07 on 10/10/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var hubIDField: UITextField!
    
    @IBAction func back(sender: UIButton) {
        self.performSegue(withIdentifier: "registerBack", sender: self)
    }
    
    @IBAction func register(sender: UIButton) {
        
        let email = usernameField.text!
        let password = passwordField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil {
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if error == nil {
                        
                        let db = Firestore.firestore()
                        var ref: DocumentReference? = nil
                        
                        let data = ["hubID": self.hubIDField.text!]
                        
                        ref = db.collection("users").document(email)
                        ref?.setData(data)
                        
                        self.performSegue(withIdentifier: "registerSuccess", sender: self)
                    }
                }
            } else {
                let str = error?.localizedDescription
                let alert = UIAlertController(title: "Registration Failed", message: str, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Bruh"), style: .`default`, handler: { _ in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}
