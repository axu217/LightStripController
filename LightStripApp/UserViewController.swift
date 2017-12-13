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
    
    @IBAction func logOut(sender: UIButton) {
        try! Auth.auth().signOut()
        
        let _ = AppMeta.AppDelegate.deviceStore.saveChanges()
        AppMeta.AppDelegate.colorStore.saveChanges()
        
        UserDefaults.standard.set(false, forKey: Constants.isUserLoggedIn)
        
        AppMeta.moveToLogin()
        
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
        tab.navigationItem.title = UserViewController.navTitle
        tab.navigationItem.leftBarButtonItem = nil
        tab.navigationItem.rightBarButtonItem = nil
    }
    
    
}
