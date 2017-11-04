//
//  ColorsCollectionViewController.swift
//  LightStripApp
//
//  Created by AXE07 on 10/25/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit
import CocoaMQTT

class ColorsCollectionViewController: UICollectionViewController {
    
    
    var alertController: UIAlertController?
    
    var colorStore: ColorStore! {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.colorStore
        }
    }
    var device: Device!
    
    @objc func addColor() {
        performSegue(withIdentifier: "AddColor", sender: self)
    }
    
    @objc func receivedMessage(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let message = userInfo["message"] as! CocoaMQTTMessage
        
        let dict = HubCommandHelper.getJSONResponse(text: message.string!)!
        if (dict.keys.contains("status")) && dict["status"] == "Pass"  {
            
            self.alertController!.title = "Success"
            self.alertController!.message = "Response successful"
            self.alertController?.view.setNeedsLayout()
            self.alertController?.view.setNeedsDisplay()
            
        } else {
            
            self.alertController?.title = "Failure"
            self.alertController?.message = "Please check your internet conection and try again"
            
        }
    }
    
    // MARK: View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addColor))
        
        collectionView?.reloadData()
        
        let name = NSNotification.Name(rawValue: "MQTTMessageNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(receivedMessage(notification:)), name: name, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0xE8ECEE)
        collectionView!.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    
    
}

extension ColorsCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorStore.allColors.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! ColorCell
        cell.backgroundColor = colorStore.allColors[indexPath.row]
        cell.layer.masksToBounds = true;
        cell.layer.cornerRadius = 6;
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        let color = colorStore.allColors[index]
        let message = HubCommandHelper.createSingleColorCommand(device: device, color: color)
        NetworkHelper.publish(message: message)
        self.alertController = UIAlertController(title: "Sending Command", message: "Please wait until the server responds", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: { _ in
            self.alertController?.dismiss(animated: true, completion: nil)
        })
        alertController?.addAction(action)
        self.present(alertController!, animated: true, completion: nil)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
