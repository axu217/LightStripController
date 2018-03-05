//
//  HomeViewController.swift
//  LightStripController
//
//  Created by AXE07 on 10/13/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit

class HomeTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBar.isTranslucent = false
        //self.tabBar.tintColor = UIColor(rgb: 0x01A185)
        
        for item in self.tabBar.items! {
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

    }
    
}
