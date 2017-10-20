//
//  FavoriteViewController.swift
//  LightStripController
//
//  Created by AXE07 on 10/14/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit
import Firebase

class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(sender: UIButton) {
        
        try! Auth.auth().signOut()
        
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        
        self.performSegue(withIdentifier: "logout", sender: self)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
