//
//  UserViewController.swift
//  LightStripApp
//
//  Created by AXE07 on 10/31/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit
import Firebase

class UserViewController: UIViewController {
    
    @IBOutlet var logoutButton: UIButton!
    
    @IBAction func logOut(sender: UIButton) {
        try! Auth.auth().signOut()
        
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginScreenViewController: LoginScreenViewController = storyboard.instantiateViewController(withIdentifier: "LoginScreenViewController") as! LoginScreenViewController
        loginScreenViewController.view.layoutIfNeeded()
        UIView.transition(with: appDelegate.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
            appDelegate.window?.rootViewController = loginScreenViewController
        }, completion: nil)
        
 
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor(rgb: 0xE8ECEE)
        logoutButton.layer.cornerRadius = 5
        logoutButton.backgroundColor = UIColor.red
        logoutButton.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tab = self.parent as! HomeTabViewController
        tab.navigationItem.title = "User"
    }
    
    
}