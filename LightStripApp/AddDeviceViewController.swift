//
//  AddDeviceViewController.swift
//  LightStripApp
//
//  Created by AXE07 on 10/23/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit
import Firebase
import CocoaMQTT

class AddDeviceViewController: UIViewController {
    
    var deviceStore: DeviceStore!
    var linkTimer: Timer?
    var timeOutTimer: Timer?
    
    var waitingAlert: UIAlertController?
    
    @IBOutlet var deviceName: UITextField!
    
    @IBAction func confirmAdd(sender: UIButton!) {
        
        NetworkFacade.enterLinkingMode()
        
        linkTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(checkLink), userInfo: nil, repeats: true)
        timeOutTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(timeOut), userInfo: nil, repeats: false)
        
        waitingAlert = UIAlertController(title: "Linking", message: "Please wait 30 seconds for the device to connect", preferredStyle: .alert)
        waitingAlert?.customAddAction(title: "Dismiss", lambda: {
            self.waitingAlert?.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        })
        self.present(waitingAlert!, animated: true, completion: nil)
    }
    
    @IBAction func back(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func checkLink() {
        NetworkFacade.checkLinkingStatus()
    }
    
    @objc func timeOut() {
        linkTimer!.invalidate()
        waitingAlert!.message = "Linking Failed. Check your hub's connectivity and the hub ID number and try again."
    }
    
    @objc func receivedMessage(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let dict = userInfo[Constants.message] as! [String: String]
        
        if (dict.keys.contains(Constants.linkStatus))  {
            let linkStatus = dict[Constants.linkStatus]
            
            if linkStatus == AddDeviceViewController.LINKINGSUCCESSFULSTATUS || linkStatus == AddDeviceViewController.ALREADYLINKEDSTATUS {
                
                linkTimer?.invalidate()
                timeOutTimer?.invalidate()
                
                if linkStatus == AddDeviceViewController.LINKINGSUCCESSFULSTATUS {
                    waitingAlert!.message = "Linking Successful"
                } else {
                    waitingAlert!.message = "Already Linked"
                }
                deviceStore.addDevice(newname: deviceName.text!, newID: (dict[Constants.id]))
   
            } else {
                
            }
        }
    }
    
    // MARK: View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let name = NSNotification.Name(rawValue: Constants.message)
        NotificationCenter.default.addObserver(self, selector: #selector(receivedMessage(notification:)), name: name, object: nil)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
        
    }
  

}

extension AddDeviceViewController {
    static let ALREADYLINKEDSTATUS = "Device was linked before"
    static let LINKINGSUCCESSFULSTATUS = "Linked to new device"
    
}





