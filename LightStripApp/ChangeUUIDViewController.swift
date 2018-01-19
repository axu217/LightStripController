//
//  ChangeUUIDViewController.swift
//  LightStripApp
//
//  Created by AXE07 on 11/8/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit
import SVProgressHUD

class ChangeUUIDViewController: UIViewController, UITextFieldDelegate {
    
    static let navTitle = "Change UUID"
    
    @IBOutlet var newUUIDTextField: UITextField!
    
    @IBAction func confirmChange(sender: UIButton) {
        
        if(newUUIDTextField.text?.count != 8) {
            let alert = UIAlertController.createAlert(title: "Invalid Hub ID", message: "Please enter a valid 8 digit hub ID found on the back of your hub")
            alert.customAddAction(title: "Dismiss") {
                alert.dismiss(animated: true, completion: nil)
            }
            present(alert, animated: true, completion: nil)
        } else {
            SVProgressHUD.show(withStatus: "Updating Hub ID")
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            UserDefaults.standard.set(newUUIDTextField.text!, forKey: Constants.uuid)
            FirebaseHelper.setHubID(email: UserDefaults.standard.value(forKey: Constants.email) as! String, hubID: newUUIDTextField.text!) {
                SVProgressHUD.showInfo(withStatus: "Success!")
                
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(success), name: NSNotification.Name(rawValue: "SVProgressHUDDidDisappearNotification"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func success() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor(rgb: 0xE8ECEE)
        newUUIDTextField.delegate = self
        self.navigationItem.title = ChangeUUIDViewController.navTitle
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newUUIDTextField.resignFirstResponder()
        return false
    }
}
