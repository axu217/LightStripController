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
    
    static let navTitle = "User"
    
    @IBOutlet var logoutButton: UIButton!
    
    let colorStore = AppMeta.AppDelegate.colorStore
    
    @IBAction func logOut(sender: UIButton) {
        try! Auth.auth().signOut()
        
        let _ = AppMeta.AppDelegate.deviceStore.saveChanges()
        colorStore.saveChanges()
        
        UserDefaults.standard.set(false, forKey: Constants.isUserLoggedIn)
        
        AppMeta.moveToLogin()
        
    }
    



    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
}
