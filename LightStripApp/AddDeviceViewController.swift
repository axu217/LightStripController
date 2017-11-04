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
        
        let uuid = UserDefaults.standard.object(forKey: "uuid") as! String

        
        let cmd: HubCommand = HubCommand(cmd: "e_l", grp: "01", uuid: uuid, ser: "123", msgid: "123", as_c: "1")
        let enterLinkingCommand = HubCommandHelper.createHubCommand(hubCommand: cmd)
        NetworkHelper.publish(message: enterLinkingCommand)
        
        linkTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(checkLink), userInfo: nil, repeats: true)
        timeOutTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(timeOut), userInfo: nil, repeats: false)
        
        waitingAlert = UIAlertController(title: "Linking", message: "Please wait for device to connect", preferredStyle: .alert)
        self.present(waitingAlert!, animated: true, completion: nil)
    }
    
    @objc func checkLink() {
        let uuid = UserDefaults.standard.object(forKey: "uuid") as! String
        let cmd: HubCommand = HubCommand(cmd: "g_ls", grp: "01", uuid: uuid, ser: "123", msgid: "123", as_c: "1")
        let checkLinkingCommand = HubCommandHelper.createHubCommand(hubCommand: cmd)
        NetworkHelper.publish(message: checkLinkingCommand)
    }
    
    @objc func timeOut() {
        linkTimer!.invalidate()
        waitingAlert!.message = "Linking Failed"
        waitingAlert!.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: "lorem ipsum"), style: .`default`, handler: { _ in
            self.waitingAlert!.dismiss(animated: true, completion: nil)
        }))
    }
    
    @objc func receivedMessage(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let message = userInfo["message"] as! CocoaMQTTMessage
        
        let dict = HubCommandHelper.getJSONResponse(text: message.string!)
        if (dict?.keys.contains("link_status"))! {
            if dict!["link_status"] == "Linked to new device" {
                linkTimer?.invalidate()
                timeOutTimer?.invalidate()
                waitingAlert!.message = "Linking Successful"
                waitingAlert!.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: "lorem ipsum"), style: .`default`, handler: { _ in
                    self.waitingAlert!.dismiss(animated: true, completion: nil)
                }))
                
                deviceStore.addDevice(newname: deviceName.text!, newID: (dict!["id"]))
                
            } else if dict!["link_status"] == "Device was linked before" {
                linkTimer?.invalidate()
                timeOutTimer?.invalidate()
                waitingAlert!.message = "Already Linked"
                waitingAlert!.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: "lorem ipsum"), style: .`default`, handler: { _ in
                    self.waitingAlert!.dismiss(animated: true, completion: {
                        
                    })
                    self.deviceStore.addDevice(newname: self.deviceName.text!, newID: (dict!["id"]))
                    self.navigationController?.popViewController(animated: true)
                }))
                
                
                
            } else {
                
            }
        }
    }
    
    // MARK: View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let name = NSNotification.Name(rawValue: "MQTTMessageNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(receivedMessage(notification:)), name: name, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }


    

}





