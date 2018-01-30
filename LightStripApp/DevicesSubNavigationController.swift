//
//  DevicesSubNavigationController.swift
//  LightStripApp
//
//  Created by Zhe Xu on 2018/01/30.
//  Copyright © 2018 ZheChengXu. All rights reserved.
//

import UIKit

class DevicesSubNavigationController: UINavigationController {

    
    var device: Device!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        //navigationBar.setBackgroundImage(UIImage(), for: .default)
        //navigationBar.shadowImage = UIImage()
        
        let yourBackImage = UIImage(named: "backButton.png")
        navigationBar.backIndicatorImage = yourBackImage
        navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        
        
        
        let root = viewControllers.first as! ControlDeviceViewController
        root.device = device
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
