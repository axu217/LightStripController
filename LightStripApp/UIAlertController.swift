//
//  UIAlertController.swift
//  LightStripApp
//
//  Created by AXE07 on 11/17/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    
    static func createAlertAndPresent(viewController: UIViewController, title: String, message: String) -> UIAlertController {
        let alert = UIAlertController.createAlert(title: title, message: message)
        
        viewController.present(alert, animated: true, completion: nil)
        return alert
    }
    
    static func createAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return alert
    }
    
    func customAddAction(title: String, lambda: @escaping () -> ()) {
        self.addAction(UIAlertAction(title: NSLocalizedString(title, comment: "Bruh"), style: .`default`, handler: { _ in
            lambda()
        }))
    }
    

}
