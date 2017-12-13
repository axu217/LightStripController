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
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor(rgb: 0x01A185)
        
        let tabFav = tabBar.items![0]
        tabFav.image=UIImage(named: "favoritesTab.png")?.withRenderingMode(.alwaysOriginal) // deselect image
        tabFav.selectedImage = UIImage(named: "favoritesTabSelected.png")?.withRenderingMode(.alwaysOriginal) // select image

        
        let tabDevices = tabBar.items![1]
        tabDevices.image=UIImage(named: "devicesTab.png")?.withRenderingMode(.alwaysOriginal)
        tabDevices.selectedImage=UIImage(named: "devicesTabSelected.png")?.withRenderingMode(.alwaysOriginal)
                
        let tabUser = tabBar.items![2]
        tabUser.image=UIImage(named: "userTab.png")?.withRenderingMode(.alwaysOriginal)
        tabUser.selectedImage=UIImage(named: "userTabSelected.png")?.withRenderingMode(.alwaysOriginal)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
