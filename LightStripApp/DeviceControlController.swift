//
//  ColorsCollectionViewController.swift
//  LightStripApp
//
//  Created by AXE07 on 10/25/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit
import CocoaMQTT

class DeviceControlController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    
    var colorStore: ColorStore!
    var device: Device!
    
    var alertController: UIAlertController?
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var deviceTitle: UILabel!

    @IBAction func userChangeMode(_ sender: UISegmentedControl) {
            
            let index = sender.selectedSegmentIndex
            if(index == 0) {

            } else if (index == 1) {
                NetworkFacade.setGradientMode(device: device)
            } else {
                NetworkFacade.setTwinkleMode(device: device)
            }
        }

    
    
    

    
    @objc func receivedMessage(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let dict = userInfo[Constants.message] as! [String: String]
        
        if (dict.keys.contains(Constants.status)) && dict[Constants.status] == "Pass"  {
            
            self.alertController?.title = "Success"
            self.alertController?.message = "Response successful"
            self.alertController?.view.setNeedsLayout()
            self.alertController?.view.setNeedsDisplay()
            
        } else {
            
            self.alertController?.title = "Failure"
            self.alertController?.message = "Please check your internet conection and try again"
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Constants.colorToAddColor) {
            let dest = segue.destination as! AddColorViewController
            dest.colorStore = colorStore
        }
    }
    
    // MARK: View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let name = NSNotification.Name(rawValue: Constants.message)
        NotificationCenter.default.addObserver(self, selector: #selector(receivedMessage(notification:)), name: name, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationItem.title = device.name
        deviceTitle.text = device.name
        

    }
    
   
    
    
    
}

extension DeviceControlController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorStore.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.colorCollectionCell, for: indexPath) as! ColorCell
        cell.backgroundColor = colorStore.getColorByIndex(index: indexPath.row)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = colorStore.getColorByIndex(index: indexPath.row)
        
        NetworkFacade.setColor(device: device, color: color)

        self.alertController = UIAlertController(title: "Sending Command", message: "Please wait until the server responds", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: { _ in
            self.alertController!.dismiss(animated: true, completion: nil)
        })
        alertController!.addAction(action)
        self.present(alertController!, animated: true, completion: nil)
    }
    
}
