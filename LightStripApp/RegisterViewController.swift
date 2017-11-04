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
    
    var waitingAlert: UIAlertController?
    
    @IBAction func back(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func register(sender: UIButton) {
        
        let email = usernameField.text!
        let password = passwordField.text!
        waitingAlert = UIAlertController(title: "Registering", message: "Please wait for the registration process to complete", preferredStyle: .alert)
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil {
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    
                    guard user != nil else {
                        print(error.debugDescription)
                        return
                    }
                    
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(password, forKey: "password")
                    UserDefaults.standard.set(self.hubIDField.text!, forKey: "uuid")
                    UserDefaults.standard.synchronize()
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let db = (appDelegate.firebaseDB)!
                    let ref = db.collection("users").document(email)
                    let data = ["hubID": self.hubIDField.text!]
                    ref.setData(data)
                    
                    NetworkHelper.connect()
                    
  
                    
                }
            } else {
                let str = error?.localizedDescription
                self.waitingAlert?.title = "Registration Failed"
                self.waitingAlert?.message = str
                self.waitingAlert?.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Bruh"), style: .`default`, handler: { _ in
                    self.waitingAlert?.dismiss(animated: true, completion: nil)
                }))
            }
        }
        
    }
    
    @objc func didSubscribe() {
        waitingAlert?.dismiss(animated: true, completion: {
            let window = UIApplication.shared.keyWindow!
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let navigationController: HomeNavigationController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as! HomeNavigationController
            navigationController.view.layoutIfNeeded()
            
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                window.rootViewController = navigationController
            }, completion: nil)
            
        })
        
    }
    
    // MARK: View Methods
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let name = NSNotification.Name(rawValue: "subscribeAck")
        NotificationCenter.default.addObserver(self, selector: #selector(didSubscribe), name: name, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
}
