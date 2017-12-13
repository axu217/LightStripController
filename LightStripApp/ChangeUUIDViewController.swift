//
//  ChangeUUIDViewController.swift
//  LightStripApp
//
//  Created by AXE07 on 11/8/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit

class ChangeUUIDViewController: UIViewController, UITextFieldDelegate {
    
    static let navTitle = "Change UUID"
    
    @IBOutlet var newUUIDTextField: UITextField!
    
    @IBAction func confirmChange(sender: UIButton) {
        UserDefaults.standard.set(newUUIDTextField.text!, forKey: Constants.uuid)
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
