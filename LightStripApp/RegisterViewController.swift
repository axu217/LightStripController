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
        let hubID = self.hubIDField.text!
        if(hubID.count != 8) {
            let alert = UIAlertController.createAlertAndPresent(viewController: self, title: "Invalid Hub ID", message: "Please enter a valid 8-digit hub ID found on the back of your hub.")
            alert.customAddAction(title: "Dismiss") {
                alert.dismiss(animated: true, completion: nil)
            }
            return
        }
        
        let email = usernameField.text!
        let password = passwordField.text!
        waitingAlert = UIAlertController.createAlertAndPresent(viewController: self, title: "Registering", message: "Please wait for the registration process to complete")
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil {
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    
                    UserDefaults.standard.set(true, forKey: Constants.isUserLoggedIn)
                    UserDefaults.standard.set(email, forKey: Constants.email)
                    UserDefaults.standard.set(password, forKey: Constants.password)
                    UserDefaults.standard.set(self.hubIDField.text!, forKey: Constants.uuid)
                    UserDefaults.standard.synchronize()
                    
                    let group = DispatchGroup()
                   
                    group.enter()
                    NetworkFacade.connect {
                        group.leave()
                    }
                    
                    group.enter()
                    FirebaseHelper.setHubID(email: email, hubID: hubID) {
                        group.leave()
                    }
                    
                    
 
                    group.notify(queue: .main) {
                        self.performSegue(withIdentifier: "registerToHome", sender: self)
                    }
                    
                    
                }
            } else {
                let str = error?.localizedDescription
                self.waitingAlert?.title = "Registration Failed"
                self.waitingAlert?.message = str
                self.waitingAlert?.customAddAction(title: "Dismiss") {
                    self.waitingAlert?.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    

    // MARK: View Methods
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0xE8ECEE)
        self.hideKeyboardWhenTappedAround()
    }
}
