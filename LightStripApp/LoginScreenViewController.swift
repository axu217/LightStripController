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
        waitingAlert = UIAlertController(title: "Logging In", message: "Connecting to the server", preferredStyle: .alert)
        self.present(waitingAlert!, animated: true, completion: nil)
        
        let email = usernameInput.text!
        let password = passwordInput.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if user != nil {
                
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(password, forKey: "password")
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let docRef = appDelegate.firebaseDB!.collection("users").document(email)
                docRef.getDocument { (document, error) in
                    if let document = document {
                        let dict = document.data() as! [String: String]
                        let uuid = dict["hubID"]
                        UserDefaults.standard.set(uuid, forKey: "uuid")
                    } else {
                        print((error! as NSError).localizedDescription)
                    }
                }
                UserDefaults.standard.synchronize()
                
                NetworkHelper.connect()
                
            } else {
                self.waitingAlert?.dismiss(animated: true, completion: nil)
                let alert = UIAlertController(title: "Registration Failed", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Bruh"), style: .`default`, handler: { _ in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }

        }
        
    }
    
    @IBAction func register(sender: UIButton) {
        passwordInput.resignFirstResponder()
        self.performSegue(withIdentifier: "register", sender: self)
    }
    
    @objc func didSubscribe() {
        waitingAlert?.dismiss(animated: true, completion: {
            
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let navigationController: HomeNavigationController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as! HomeNavigationController
            navigationController.view.layoutIfNeeded()
            
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                window.rootViewController = navigationController
            }, completion: nil)
            
        })
    }

    // MARK: View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        passwordInput.delegate = self
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        super.viewWillDisappear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        let name = NSNotification.Name(rawValue: "subscribeAck")
        NotificationCenter.default.addObserver(self, selector: #selector(didSubscribe), name: name, object: nil)
    }
    
    
        
    
}
